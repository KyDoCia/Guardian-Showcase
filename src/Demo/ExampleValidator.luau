--!strict

local ExampleValidator = {}

export type Request = {
	action: string,
	targetId: number?,
}

export type Context = {
	isAuthorized: boolean,
}

export type Result =
	{ ok: true }
	| { ok: false, code: string }

function ExampleValidator.validate(context: Context, request: unknown): Result
	if typeof(request) ~= "table" then
		return { ok = false, code = "malformed_request" }
	end

	local candidate = request :: any

	if typeof(candidate.action) ~= "string" then
		return { ok = false, code = "invalid_schema" }
	end

	if candidate.targetId ~= nil and typeof(candidate.targetId) ~= "number" then
		return { ok = false, code = "invalid_schema" }
	end

	if not context.isAuthorized then
		return { ok = false, code = "not_authorized" }
	end

	return { ok = true }
end

return ExampleValidator
