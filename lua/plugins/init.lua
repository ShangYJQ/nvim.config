--  plugins list
--  在大多数情况下会自动编译 编译失败请手动编译
vim.pack.add({

	{ src = "https://github.com/nvim-treesitter/nvim-treesitter",          version = "main" },

	-- Themes
	{ src = "https://github.com/catppuccin/nvim",                          name = "catppuccin" },
	{ src = "https://github.com/navarasu/onedark.nvim" },
	{ src = "https://github.com/rebelot/kanagawa.nvim" },
	{ src = "https://github.com/folke/tokyonight.nvim" },
	{ src = "https://github.com/nvim-tree/nvim-web-devicons" },
	{ src = "https://github.com/nvim-lualine/lualine.nvim" },
	{ src = "https://github.com/nvim-mini/mini.indentscope" },
	-- -- LSP and diagnostics
	{ src = "https://github.com/neovim/nvim-lspconfig" },
	{ src = "https://github.com/rachartier/tiny-inline-diagnostic.nvim" },

	{ src = "https://github.com/windwp/nvim-autopairs" },

	{ src = "https://github.com/saghen/blink.cmp" },

	-- -- Formatting
	{ src = "https://github.com/stevearc/conform.nvim" },

	-- -- Editing enhancement
	{ src = "https://github.com/nvim-telescope/telescope.nvim" },
	{ src = "https://github.com/nvim-lua/plenary.nvim" },
	{ src = "https://github.com/stevearc/oil.nvim" },
	{ src = "https://github.com/nvim-mini/mini.surround" },
	{ src = "https://github.com/MeanderingProgrammer/render-markdown.nvim" },
	{ src = "https://github.com/jake-stewart/multicursor.nvim" },
	{ src = "https://github.com/lewis6991/gitsigns.nvim" },
})

require("plugins.themes")
require("plugins.nvim-treesitter")
require("plugins.blink-cmp")
require("plugins.nvim-autopairs")
require("plugins.conform")
require("plugins.lualine")
require("plugins.gitsigns")
require("plugins.mini-surround")
require("plugins.telescope")
require("plugins.render-markdown")
require("plugins.tiny-inline-diagnostics")
require("plugins.oil")
require("plugins.multicursor-nvim")
require("plugins.mini-indentscope")
