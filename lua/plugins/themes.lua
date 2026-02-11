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

-- NOTE: See highlights here
-- https://github.com/rebelot/kanagawa.nvim/blob/master/lua/kanagawa/highlights/plugins.lua
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

			-- Neo tree
			NeoTreeTabInactive = { link = "TabLine" },
			NeoTreeTabActive = { link = "TabLineSel" },
			NeoTreeTabSeparatorInactive = { link = "NeoTreeTabInactive" },
			NeoTreeTabSeparatorActive = { link = "NeoTreeTabActive" },
			NeoTreeRootName = { fg = theme.syn.identifier, bold = true },
			NeoTreeModified = { link = "String" },
			NeoTreeGitModified = { fg = theme.vcs.changed },
			NeoTreeGitAdded = { fg = theme.vcs.added },
			NeoTreeGitDeleted = { fg = theme.vcs.removed },
			NeoTreeGitStaged = { fg = theme.vcs.added },
			NeoTreeGitConflict = { fg = theme.diag.error },
			NeoTreeGitUntracked = { link = "NeoTreeGitModified", default = true },
			NeoTreeGitUnstaged = { link = "NeoTreeGitModified", default = true },
			NeoTreeIndentMarker = { link = "NonText" },

			-- Notify
			NotifyBackground = { bg = theme.ui.bg },
			NotifyERRORBorder = { link = "DiagnosticError" },
			NotifyWARNBorder = { link = "DiagnosticWarn" },
			NotifyINFOBorder = { link = "DiagnosticInfo" },
			NotifyHINTBorder = { link = "DiagnosticHint" },
			NotifyDEBUGBorder = { link = "Debug" },
			NotifyTRACEBorder = { link = "Comment" },
			NotifyERRORIcon = { link = "DiagnosticError" },
			NotifyWARNIcon = { link = "DiagnosticWarn" },
			NotifyINFOIcon = { link = "DiagnosticInfo" },
			NotifyHINTIcon = { link = "DiagnosticHint" },
			NotifyDEBUGIcon = { link = "Debug" },
			NotifyTRACEIcon = { link = "Comment" },
			NotifyERRORTitle = { link = "DiagnosticError" },
			NotifyWARNTitle = { link = "DiagnosticWarn" },
			NotifyINFOTitle = { link = "DiagnosticInfo" },
			NotifyHINTTitle = { link = "DiagnosticHint" },
			NotifyDEBUGTitle = { link = "Debug" },
			NotifyTRACETitle = { link = "Comment" },
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

require("material").setup({

	contrast = {
		terminal = true, -- Enable contrast for the built-in terminal
		sidebars = true, -- Enable contrast for sidebar-like windows ( for example Nvim-Tree )
		floating_windows = true, -- Enable contrast for floating windows
		cursor_line = true, -- Enable darker background for the cursor line
		lsp_virtual_text = true, -- Enable contrasted background for lsp virtual text
		non_current_windows = true, -- Enable contrasted background for non-current windows
		filetypes = {}, -- Specify which filetypes get the contrasted (darker) background
	},

	plugins = { -- Uncomment the plugins that you use to highlight them
		-- Available plugins:
		"blink",
		-- "coc",
		-- "colorful-winsep",
		-- "dap",
		-- "dashboard",
		-- "eyeliner",
		-- "fidget",
		-- "flash",
		"gitsigns",
		-- "harpoon",
		-- "hop",
		-- "illuminate",
		-- "indent-blankline",
		-- "lspsaga",
		"mini",
		"neo-tree",
		-- "neogit",
		-- "neorg",
		-- "neotest",
		-- "noice",
		-- "nvim-cmp",
		-- "nvim-navic",
		-- "nvim-notify",
		-- "nvim-tree",
		"nvim-web-devicons",
		-- "rainbow-delimiters",
		-- "sneak",
		"telescope",
		-- "trouble",
		-- "which-key",
	},

	disable = {
		colored_cursor = false, -- Disable the colored cursor
		borders = false, -- Disable borders between vertically split windows
		background = false, -- Prevent the theme from setting the background (NeoVim then uses your terminal background)
		term_colors = false, -- Prevent the theme from setting terminal colors
		eob_lines = false, -- Hide the end-of-buffer lines
	},

	high_visibility = {
		lighter = false, -- Enable higher contrast text for lighter style
		darker = false, -- Enable higher contrast text for darker style
	},

	lualine_style = "default", -- Lualine style ( can be 'stealth' or 'default' )

	async_loading = true, -- Load parts of the theme asynchronously for faster startup (turned on by default)

	custom_colors = nil, -- If you want to override the default colors, set this to a function

	custom_highlights = {

		-- ufo color
		FoldColumn = { fg = "#6B7280", bg = "NONE" },
		CursorLineFold = { fg = "#9CA3AF", bg = "NONE" }, -- 当前行稍亮一点
	}, -- Overwrite highlights with your own
})
