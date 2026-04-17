--  plugins list
--  在大多数情况下会自动编译 编译失败请手动编译
vim.pack.add({

	---------------------------------------- core plugins ----------------------------------------

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
	{ src = "https://github.com/rachartier/tiny-cmdline.nvim" },

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
	-- { src = "https://github.com/stevearc/oil.nvim" },

	{ src = "https://github.com/lewis6991/gitsigns.nvim" },
	{ src = "https://github.com/folke/todo-comments.nvim" },
	{ src = "https://github.com/windwp/nvim-ts-autotag" },
	{ src = "https://github.com/folke/flash.nvim" },

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

	-- { src = "https://github.com/jake-stewart/multicursor.nvim" },

	-- cd .local/share/nvim/site/pack/core/opt/telescope-fzf-native.nvim
	-- make
	{ src = "https://github.com/nvim-telescope/telescope-fzf-native.nvim" },
	{ src = "https://github.com/nvim-telescope/telescope-project.nvim" },

	---------------------------------------- lazy load plugins ----------------------------------------

	-- overseer
	-- { src = "https://github.com/stevearc/overseer.nvim" },

	-- { src = "https://github.com/akinsho/toggleterm.nvim" },
	-- { src = "https://github.com/ShangYJQ/sloat.git" },

	-- { src = "https://github.com/nvim-neo-tree/neo-tree.nvim" },
	-- { src = "https://github.com/MunifTanjim/nui.nvim" }, -- dependent for neo-tree

	-- cph from bcyz
	-- { src = "https://github.com/beicanzhuzhu/cph.nvim" },
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
-- require("plugins.sloat") -- lazy loaded
-- require("plugins.toggleterm") -- lazy loaded
-- require("plugins.oil")
-- require("plugins.neo-tree") -- lazy loaded
require("plugins.nvim-ufo")
require("plugins.todo-comments")
require("plugins.blink-indent")
require("plugins.tiny-cmdline")
require("plugins.flash")
-- require("plugins.mini-files")
-- require("plugins.multicursor-nvim") -- lazy loaded
-- require("plugins.mini-indentscope")
-- require("plugins.overseer") -- lazy loaded

---------------------------------------- lazy load plugins ----------------------------------------

local lazy = require("utlis.lazy")

---------------------------------------- multicursor ----------------------------------------

local function load_multicursor()
	vim.pack.add({ { src = "https://github.com/jake-stewart/multicursor.nvim" } })
	require("plugins.multicursor-nvim")
end

lazy.keymap_stub({ "n", "x" }, "<S-c>", load_multicursor, { desc = "Multicursor: add cursor down" })
lazy.keymap_stub({ "n", "x" }, "<leader><S-c>", load_multicursor, { desc = "Multicursor: skip cursor down" })
lazy.keymap_stub({ "n", "x" }, "<leader>m", load_multicursor, { desc = "Multicursor: clear cursors" })

---------------------------------------- toggleterm ----------------------------------------

-- local function load_toggleterm()
-- 	vim.pack.add({ { src = "https://github.com/akinsho/toggleterm.nvim" } })
-- 	require("plugins.toggleterm")
-- end
--
-- lazy.keymap_stub("n", "<leader>t", load_toggleterm, { noremap = true, silent = true, desc = "ToggleTerm float" })
-- lazy.command_stub("ToggleTerm", load_toggleterm)

---------------------------------------- sloat ----------------------------------------

local function load_sloat()
	vim.pack.add({ { src = "https://github.com/ShangYJQ/sloat.git" } })
	require("plugins.sloat")
end

lazy.keymap_stub("n", "<leader>t", load_sloat, { noremap = true, silent = true, desc = "Toggle sloat term" })
lazy.command_stub("Sloat", load_sloat)

---------------------------------------- neo-tree ----------------------------------------

local function load_neotree()
	vim.pack.add({
		{ src = "https://github.com/nvim-neo-tree/neo-tree.nvim" },
		{ src = "https://github.com/MunifTanjim/nui.nvim" },
	})
	require("plugins.neo-tree")
end

lazy.keymap_stub("n", "<leader>e", load_neotree, { silent = true, desc = " Neotree toggle" })
lazy.command_stub("Neotree", load_neotree)

---------------------------------------- cph ----------------------------------------

local function load_cph()
	vim.pack.add({ { src = "https://github.com/beicanzhuzhu/cph.nvim" } })
	require("plugins.cph")
end

lazy.keymap_stub("n", "<leader>x", load_cph, { silent = true, desc = " CPH toggle" })
lazy.command_stub("ToggleCPH", load_cph)

---------------------------------------- overseer ----------------------------------------

local function load_overseer()
	vim.pack.add({ { src = "https://github.com/stevearc/overseer.nvim" } })
	require("plugins.overseer")
end

lazy.keymap_stub("n", "<leader>oo", load_overseer, { desc = "Overseer: toggle task list" })
lazy.keymap_stub("n", "<leader>ot", load_overseer, { desc = "Overseer: run task" })
lazy.keymap_stub("n", "<leader>os", load_overseer, { desc = "Overseer: shell task" })
lazy.keymap_stub("n", "<leader>oa", load_overseer, { desc = "Overseer: task action" })

lazy.command_stub("OverseerToggle", load_overseer)
lazy.command_stub("OverseerRun", load_overseer)
lazy.command_stub("OverseerShell", load_overseer)
lazy.command_stub("OverseerTaskAction", load_overseer)

---------------------------------------- dap ----------------------------------------

local function load_dap()
	vim.pack.add({
		{ src = "https://codeberg.org/mfussenegger/nvim-dap" },
		{ src = "https://github.com/igorlfs/nvim-dap-view" },
	})
	require("plugins.dap")
end

lazy.keymap_stub("n", "<F5>", load_dap, { desc = "DAP Continue" })
lazy.keymap_stub("n", "<leader>dn", load_dap, { desc = "DAP Step Over" })
lazy.keymap_stub("n", "<leader>di", load_dap, { desc = "DAP Step Into" })
lazy.keymap_stub("n", "<leader>do", load_dap, { desc = "DAP Step Out" })
lazy.keymap_stub("n", "<Leader>b", load_dap, { desc = "DAP Toggle Breakpoint" })
lazy.keymap_stub("n", "<Leader>dq", load_dap, { desc = "DAP Quit" })
lazy.keymap_stub("n", "<Leader>dv", load_dap, { desc = "DAP View Toggle" })
