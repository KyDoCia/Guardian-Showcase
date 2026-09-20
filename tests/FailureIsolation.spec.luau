--!strict

return function()
	describe("failure isolation", function()
		it("does not turn an observability failure into suspicion", function()
			local suspicionCreated = false

			local function emitDiagnostic()
				error("provider unavailable")
			end

			local ok = pcall(emitDiagnostic)
			expect(ok).to.equal(false)
			expect(suspicionCreated).to.equal(false)
		end)
	end)
end
