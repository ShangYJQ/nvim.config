require("ufo").setup({
	provider_selector = function()
		return { "lsp", "indent" }
		-- return { "treesitter", "indent" }
	end,
})

local map = vim.keymap.set
local flag = true
local ufo = require("ufo")

-- Not work? Why not try one more time?
map("n", "zx", function()
	if flag then
		ufo.closeAllFolds()
		flag = false
	else
		ufo.openAllFolds()
		flag = true
	end
end, { desc = "Toggle all fold" })
