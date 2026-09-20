--!strict

local BoundedBuffer = require(script.Parent.Parent.src.Infrastructure.BoundedBuffer)

return function()
	describe("bounded diagnostic state", function()
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
	end)
end
