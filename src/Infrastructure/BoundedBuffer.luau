--!strict

local BoundedBuffer = {}
BoundedBuffer.__index = BoundedBuffer

export type Buffer<T> = typeof(setmetatable({} :: {
	capacity: number,
	items: { T },
}, BoundedBuffer))

function BoundedBuffer.new<T>(capacity: number): Buffer<T>
	assert(capacity > 0, "capacity must be positive")

	return setmetatable({
		capacity = capacity,
		items = {},
	}, BoundedBuffer) :: any
end

function BoundedBuffer.push<T>(self: Buffer<T>, value: T)
	table.insert(self.items, value)

	if #self.items > self.capacity then
		table.remove(self.items, 1)
	end
end

function BoundedBuffer.values<T>(self: Buffer<T>): { T }
	return table.clone(self.items)
end

return BoundedBuffer
