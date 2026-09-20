--!strict

local Sanitizer = require(script.Parent.Parent.src.Infrastructure.Sanitizer)

return function()
	describe("diagnostic sanitization", function()
		it("returns empty context for nil input", function()
			expect(next(Sanitizer.context(nil))).to.equal(nil)
		end)

		it("keeps only scalar diagnostic values", function()
			local output = Sanitizer.context({
				name = "demo",
				count = 4,
				enabled = true,
				nested = { secret = "drop-me" },
				callback = function() end,
			})
			expect(output.name).to.equal("demo")
			expect(output.count).to.equal("4")
			expect(output.enabled).to.equal("true")
			expect(output.nested).to.equal(nil)
			expect(output.callback).to.equal(nil)
		end)

		it("clips long keys and values", function()
			local longKey = string.rep("k", 60)
			local output = Sanitizer.context({ [longKey] = string.rep("v", 200) })
			expect(output[string.rep("k", 48)]).to.equal(string.rep("v", 160))
			expect(output[longKey]).to.equal(nil)
		end)
	end)
end
