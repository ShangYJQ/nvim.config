require("catppuccin").setup({
	integrations = {
		gitsigns = true,
		telescope = { enabled = true },
	},
	flavour = "mocha",
	term_colors = true,
})

require("onedark").setup({
	style = "warm", -- Choose between 'dark', 'darker', 'cool', 'deep', 'warm', 'warmer' and 'light'
	-- toggle_style_key = "<leader>O",
})

require("kanagawa").setup({
	transparent = false,
	dimInactive = false,
	terminalColors = true,
	overrides = function(colors)
		local theme = colors.theme
		return {
			TelescopeTitle = { fg = theme.ui.special, bold = true },
			TelescopePromptNormal = { bg = theme.ui.bg_p1 },
			TelescopePromptBorder = { fg = theme.ui.bg_p1, bg = theme.ui.bg_p1 },
			TelescopeResultsNormal = { fg = theme.ui.fg_dim, bg = theme.ui.bg_m1 },
			TelescopeResultsBorder = { fg = theme.ui.bg_m1, bg = theme.ui.bg_m1 },
			TelescopePreviewNormal = { bg = theme.ui.bg_dim },
			TelescopePreviewBorder = { bg = theme.ui.bg_dim, fg = theme.ui.bg_dim },

			-- for blink.cmp
			Pmenu = { fg = theme.ui.shade0, bg = theme.ui.bg_p1 }, -- add `blend = vim.o.pumblend` to enable transparency,,
			PmenuSel = { fg = "NONE", bg = theme.ui.bg_p2 },
			PmenuSbar = { bg = theme.ui.bg_m1 },
			PmenuThumb = { bg = "#C0A36E" },
			BlinkCmpMenuBorder = { fg = "", bg = "" },

			NormalFloat = { bg = "none" },
			FloatBorder = { bg = "none" },
			FloatTitle = { bg = "none" },
			-- LineNr = { fg = "#C0A36E", bg = "NONE" },
			CursorLineNr = { fg = colors.palette.sakuraPink, bg = "NONE" },

			-- Gitsigns
			GitSignsAdd = { fg = theme.vcs.added, bg = theme.ui.bg_gutter },
			GitSignsChange = { fg = theme.vcs.changed, bg = theme.ui.bg_gutter },
			GitSignsDelete = { fg = theme.vcs.removed, bg = theme.ui.bg_gutter },

			MiniIndentscopeSymbol = { fg = theme.syn.special1 },
			MiniIndentscopePrefix = { nocombine = true }, -- Make it invisible

			-- NeoVim
			healthError = { fg = theme.diag.error },
			healthSuccess = { fg = theme.diag.ok },
			healthWarning = { fg = theme.diag.warning },
		}
	end,
	theme = "wave",
	background = {
		dark = "wave",
		light = "lotus",
	},
})

require("tokyonight").setup({
	terminal_colors = true,
	on_highlights = function(hl, c)
		local prompt = "#2d3149"
		hl.TelescopeNormal = {
			bg = c.bg_dark,
			fg = c.fg_dark,
		}
		hl.TelescopeBorder = {
			bg = c.bg_dark,
			fg = c.bg_dark,
		}
		hl.TelescopePromptNormal = {
			bg = prompt,
		}
		hl.TelescopePromptBorder = {
			bg = prompt,
			fg = prompt,
		}
		hl.TelescopePromptTitle = {
			bg = prompt,
			fg = prompt,
		}
		hl.TelescopePreviewTitle = {
			bg = c.bg_dark,
			fg = c.bg_dark,
		}
		hl.TelescopeResultsTitle = {
			bg = c.bg_dark,
			fg = c.bg_dark,
		}
	end,
})
