vim.api.nvim_set_hl(0, "BlinkPairsOrange", { fg = "#f78c6c" })
vim.api.nvim_set_hl(0, "BlinkPairsPurple", { fg = "#c792ea" })
vim.api.nvim_set_hl(0, "BlinkPairsBlue", { fg = "#82aaff" })

vim.api.nvim_set_hl(0, "BlinkPairsUnmatched", { fg = "#ff5370" })

vim.api.nvim_set_hl(0, "BlinkPairsMatchParen", { link = "PmenuSel" })

require("blink.pairs").setup({

	mappings = {
		enabled = true,
		cmdline = true,
	},

	highlights = {
		enabled = true,
		cmdline = true,
		-- set to { 'BlinkPairs' } to disable rainbow highlighting
		groups = { "BlinkPairsOrange", "BlinkPairsPurple", "BlinkPairsBlue" },
		unmatched_group = "BlinkPairsUnmatched",

		-- highlights matching pairs under the cursor
		matchparen = {
			enabled = true,
			-- known issue where typing won't update matchparen highlight, disabled by default
			cmdline = false,
			-- also include pairs not on top of the cursor, but surrounding the cursor
			include_surrounding = false,
			group = "BlinkPairsMatchParen",
			priority = 250,
		},
	},
})
