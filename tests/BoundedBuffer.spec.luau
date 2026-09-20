--!strict

local BoundedBuffer = require(script.Parent.Parent.src.Infrastructure.BoundedBuffer)

return function()
	describe("bounded diagnostic state", function()
		it("starts empty", function()
			local buffer = BoundedBuffer.new(2)
			expect(#buffer:values()).to.equal(0)
		end)

		it("preserves insertion order before capacity", function()
			local buffer = BoundedBuffer.new(3)
			buffer:push("first")
			buffer:push("second")
			local values = buffer:values()
			expect(values[1]).to.equal("first")
			expect(values[2]).to.equal("second")
		end)

		it("never retains more than its configured capacity", function()
			local buffer = BoundedBuffer.new(2)
			buffer:push("first")
			buffer:push("second")
			buffer:push("third")
			local values = buffer:values()
			expect(#values).to.equal(2)
			expect(values[1]).to.equal("second")
			expect(values[2]).to.equal("third")
		end)

		it("keeps chronological order across repeated wraparound", function()
			local buffer = BoundedBuffer.new(3)
			for value = 1, 8 do
				buffer:push(value)
			end
			local values = buffer:values()
			expect(values[1]).to.equal(6)
			expect(values[2]).to.equal(7)
			expect(values[3]).to.equal(8)
		end)
	end)
end
