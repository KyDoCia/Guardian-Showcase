--!strict

local Sanitizer = {}

local MAX_KEY_LENGTH = 48
local MAX_VALUE_LENGTH = 160

local function clip(value: string, limit: number): string
	if #value <= limit then
		return value
	end

	return string.sub(value, 1, limit)
end

function Sanitizer.context(input: { [string]: unknown }?): { [string]: string }
	local output: { [string]: string } = {}

	if input == nil then
		return output
	end

	for key, value in input do
		if typeof(key) == "string" then
			local valueType = typeof(value)
			if valueType == "string" or valueType == "number" or valueType == "boolean" then
				output[clip(key, MAX_KEY_LENGTH)] = clip(tostring(value), MAX_VALUE_LENGTH)
			end
		end
	end

	return output
end

return Sanitizer
