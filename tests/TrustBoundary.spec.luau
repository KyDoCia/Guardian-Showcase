--!strict

local ExampleValidator = require(script.Parent.Parent.src.Demo.ExampleValidator)

return function()
	describe("request trust boundary", function()
		it("rejects malformed input", function()
			expect(ExampleValidator.validate({ isAuthorized = true }, "not-a-request").ok).to.equal(false)
		end)

		it("does not accept client-shaped authority as server authority", function()
			local request = {
				action = "admin_action",
				isAuthorized = true,
			}

			local result = ExampleValidator.validate({ isAuthorized = false }, request)
			expect(result.ok).to.equal(false)
		end)
	end)
end
