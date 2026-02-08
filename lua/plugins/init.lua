--  plugins list
--  在大多数情况下会自动编译 编译失败请手动编译
vim.pack.add({

	{ src = "https://github.com/nvim-treesitter/nvim-treesitter", version = "main" },

	-- Themes
	{ src = "https://github.com/catppuccin/nvim", name = "catppuccin" },
	{ src = "https://github.com/navarasu/onedark.nvim" },
	{ src = "https://github.com/rebelot/kanagawa.nvim" },
	{ src = "https://github.com/folke/tokyonight.nvim" },
	{ src = "https://github.com/marko-cerovac/material.nvim" },

	-- UI
	{ src = "https://github.com/nvim-tree/nvim-web-devicons" },
	{ src = "https://github.com/nvim-lualine/lualine.nvim" },
	-- { src = "https://github.com/nvim-mini/mini.indentscope" },
	{ src = "https://github.com/saghen/blink.indent" },

	-- LSP and diagnostics
	{ src = "https://github.com/neovim/nvim-lspconfig" },
	{ src = "https://github.com/rachartier/tiny-inline-diagnostic.nvim" },

	-- cd ~/.local/share/nvim/site/pack/core/opt/blink.cmp
	-- rustup override set nightly
	-- cargo build --release

	{ src = "https://github.com/saghen/blink.cmp" },

	-- Formatting
	{ src = "https://github.com/stevearc/conform.nvim" },

	-- Editing enhancement
	{ src = "https://github.com/nvim-telescope/telescope.nvim" },
	{ src = "https://github.com/nvim-lua/plenary.nvim" },
	{ src = "https://github.com/stevearc/oil.nvim" },
	{ src = "https://github.com/lewis6991/gitsigns.nvim" },
	{ src = "https://github.com/folke/todo-comments.nvim" },
	{ src = "https://github.com/windwp/nvim-ts-autotag" },
	{ src = "https://github.com/akinsho/toggleterm.nvim" },

	-- nvim-ufo
	{ src = "https://github.com/kevinhwang91/promise-async" }, -- ufo dependent
	{ src = "https://github.com/kevinhwang91/nvim-ufo" },

	-- { src = "https://github.com/nvim-mini/mini.files" },
	{ src = "https://github.com/nvim-mini/mini.surround" },
	{ src = "https://github.com/MeanderingProgrammer/render-markdown.nvim" },

	-- cd ~/.local/share/nvim/site/pack/core/opt/blink.pairs
	-- rustup override set nightly
	-- cargo build --release
	{ src = "https://github.com/saghen/blink.pairs" },

	{ src = "https://github.com/jake-stewart/multicursor.nvim" },

	-- cd .local/share/nvim/site/pack/core/opt/telescope-fzf-native.nvim
	-- make
	{ src = "https://github.com/nvim-telescope/telescope-fzf-native.nvim" },
})

-- 获得自动构建器
local status, builder = pcall(require, "utlis.builder")
if status then
	builder.setup_autobuild()
else
	vim.notify("[error] can not find builder")
end

require("plugins.themes")
require("plugins.nvim-treesitter")
require("plugins.blink-cmp")
require("plugins.blink-pairs")
require("plugins.conform")
require("plugins.lualine")
require("plugins.gitsigns")
require("plugins.mini-surround")
require("plugins.telescope")
require("plugins.render-markdown")
require("plugins.tiny-inline-diagnostics")
require("plugins.nvim-ts-autotag")
require("plugins.toggleterm")
require("plugins.oil")
require("plugins.nvim-ufo")
require("plugins.todo-comments")
require("plugins.blink-indent")
-- require("plugins.mini-files")
require("plugins.multicursor-nvim")
-- require("plugins.mini-indentscope")
