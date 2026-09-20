--!strict

local ExampleValidator = require(script.Parent.Parent.src.Demo.ExampleValidator)

return function()
	describe("request trust boundary", function()
		it("rejects non-table input", function()
			local result = ExampleValidator.validate({ isAuthorized = true }, "not-a-request")
			expect(result.ok).to.equal(false)
			expect((result :: any).code).to.equal("malformed_request")
		end)

		it("rejects missing or invalid schema fields", function()
			local missing = ExampleValidator.validate({ isAuthorized = true }, {})
			expect(missing.ok).to.equal(false)

			local wrongAction = ExampleValidator.validate({ isAuthorized = true }, { action = 42 })
			expect(wrongAction.ok).to.equal(false)

			local wrongTarget = ExampleValidator.validate({ isAuthorized = true }, {
				action = "inspect",
				targetId = "123",
			})
			expect(wrongTarget.ok).to.equal(false)
		end)

		it("does not accept client-shaped authority as server authority", function()
			local request = { action = "admin_action", isAuthorized = true }
			local result = ExampleValidator.validate({ isAuthorized = false }, request)
			expect(result.ok).to.equal(false)
			expect((result :: any).code).to.equal("not_authorized")
		end)

		it("accepts valid input only with server authorization", function()
			local result = ExampleValidator.validate({ isAuthorized = true }, {
				action = "inspect",
				targetId = 123,
			})
			expect(result.ok).to.equal(true)
		end)
	end)
end
