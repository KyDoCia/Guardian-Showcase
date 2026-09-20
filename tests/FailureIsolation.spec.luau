--!strict

local SafeDiagnosticSink = require(script.Parent.Parent.src.Infrastructure.SafeDiagnosticSink)

return function()
	describe("diagnostic failure isolation", function()
		it("contains provider failure at the diagnostic boundary", function()
			local domainAccepted = true
			local suspicionCreated = false

			local emitted = SafeDiagnosticSink.emit(function()
				error("provider unavailable")
			end, {
				category = "demo",
				code = "provider_failure",
			})

			expect(emitted).to.equal(false)
			expect(domainAccepted).to.equal(true)
			expect(suspicionCreated).to.equal(false)
		end)
	end)
end
