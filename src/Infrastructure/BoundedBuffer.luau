--!strict

local BoundedBuffer = {}
BoundedBuffer.__index = BoundedBuffer

export type Buffer<T> = typeof(setmetatable({} :: {
	capacity: number,
	size: number,
	nextIndex: number,
	items: { [number]: T },
}, BoundedBuffer))

function BoundedBuffer.new<T>(capacity: number): Buffer<T>
	assert(capacity > 0 and capacity % 1 == 0, "capacity must be a positive integer")

	return setmetatable({
		capacity = capacity,
		size = 0,
		nextIndex = 1,
		items = {},
	}, BoundedBuffer) :: any
end

function BoundedBuffer.push<T>(self: Buffer<T>, value: T)
	self.items[self.nextIndex] = value
	self.nextIndex = (self.nextIndex % self.capacity) + 1
	self.size = math.min(self.size + 1, self.capacity)
end

function BoundedBuffer.values<T>(self: Buffer<T>): { T }
	local output = table.create(self.size)

	if self.size == 0 then
		return output
	end

	local oldest = if self.size < self.capacity then 1 else self.nextIndex

	for offset = 0, self.size - 1 do
		local index = ((oldest + offset - 1) % self.capacity) + 1
		table.insert(output, self.items[index])
	end

	return output
end

return BoundedBuffer
