--!strict

local RemoteSecurityBoundary = require(script.Parent.Parent.src.Demo.RemoteSecurityBoundary)

return function()
	describe("remote security boundary", function()
		it("rejects malformed payloads", function()
			local result = RemoteSecurityBoundary.validate({ isAuthorized = true, actorId = 1 }, "invalid")
			expect(result.ok).to.equal(false)
			expect((result :: any).code).to.equal("malformed_request")
		end)

		it("rejects non-finite numeric input", function()
			for _, value in { 0 / 0, math.huge, -math.huge } do
				local result = RemoteSecurityBoundary.validate({ isAuthorized = true, actorId = 1 }, {
					action = "inspect",
					targetId = value,
				})
				expect(result.ok).to.equal(false)
				expect((result :: any).code).to.equal("invalid_schema")
			end
		end)

		it("does not accept authority from request data", function()
			local result = RemoteSecurityBoundary.validate({ isAuthorized = false, actorId = 1 }, {
				action = "inspect",
				targetId = 2,
				isAuthorized = true,
			})
			expect(result.ok).to.equal(false)
			expect((result :: any).code).to.equal("not_authorized")
		end)

		it("returns only validated fields", function()
			local result = RemoteSecurityBoundary.validate({ isAuthorized = true, actorId = 1 }, {
				action = "inspect",
				targetId = 2,
				unexpected = "discarded",
			})
			expect(result.ok).to.equal(true)
			local validated = (result :: any).request
			expect(validated.action).to.equal("inspect")
			expect(validated.targetId).to.equal(2)
			expect(validated.unexpected).to.equal(nil)
		end)

		it("keeps diagnostic failure outside request acceptance", function()
			local result = RemoteSecurityBoundary.validate({ isAuthorized = true, actorId = 1 }, {
				action = "inspect",
			}, function()
				error("diagnostic provider unavailable")
			end)
			expect(result.ok).to.equal(true)
		end)
	end)
end
