--!strict

local SafeDiagnosticSink = {}

export type Emit = (record: unknown) -> ()

function SafeDiagnosticSink.emit(emit: Emit, record: unknown): boolean
	local ok = pcall(emit, record)
	return ok
end

return SafeDiagnosticSink
