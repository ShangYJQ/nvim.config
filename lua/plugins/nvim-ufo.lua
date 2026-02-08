require("ufo").setup({
	provider_selector = function()
		return { "lsp", "indent" }
		-- return { "treesitter", "indent" }
	end,
})
