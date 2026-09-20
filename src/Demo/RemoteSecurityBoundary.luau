--!strict

local Sanitizer = require(script.Parent.Parent.Infrastructure.Sanitizer)
local SafeDiagnosticSink = require(script.Parent.Parent.Infrastructure.SafeDiagnosticSink)

local RemoteSecurityBoundary = {}

export type Context = {
	isAuthorized: boolean,
	actorId: number,
}

export type Request = {
	action: string,
	targetId: number?,
}

export type Result =
	{ ok: true, request: Request }
	| { ok: false, code: string }

export type DiagnosticEmit = (record: unknown) -> ()

local function reject(code: string, emit: DiagnosticEmit?, context: { [string]: unknown }?): Result
	if emit ~= nil then
		SafeDiagnosticSink.emit(emit, {
			category = "request_boundary",
			code = code,
			context = Sanitizer.context(context),
		})
	end

	return { ok = false, code = code }
end

function RemoteSecurityBoundary.validate(
	context: Context,
	request: unknown,
	emit: DiagnosticEmit?
): Result
	if typeof(request) ~= "table" then
		return reject("malformed_request", emit, { receivedType = typeof(request) })
	end

	local candidate = request :: any
	local action = candidate.action

	if typeof(action) ~= "string" or action == "" then
		return reject("invalid_schema", emit, { field = "action" })
	end

	local targetId = candidate.targetId
	if targetId ~= nil then
		if typeof(targetId) ~= "number" or targetId ~= targetId or targetId == math.huge or targetId == -math.huge then
			return reject("invalid_schema", emit, { field = "targetId" })
		end
	end

	if not context.isAuthorized then
		return reject("not_authorized", emit, {
			action = action,
			actorId = context.actorId,
		})
	end

	local validated: Request = {
		action = action,
		targetId = targetId,
	}

	return { ok = true, request = validated }
end

return RemoteSecurityBoundary
