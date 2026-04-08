--  plugins list
--  在大多数情况下会自动编译 编译失败请手动编译
vim.pack.add({

	----------------------- core plugins -----------------------

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
	{ src = "https://github.com/rcarriga/nvim-notify" },

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

	{ src = "https://github.com/jake-stewart/multicursor.nvim" },

	-- cd .local/share/nvim/site/pack/core/opt/telescope-fzf-native.nvim
	-- make
	{ src = "https://github.com/nvim-telescope/telescope-fzf-native.nvim" },
	{ src = "https://github.com/nvim-telescope/telescope-project.nvim" },

	----------------------- lazy load plugins -----------------------

	{ src = "https://github.com/akinsho/toggleterm.nvim" },

	{ src = "https://github.com/nvim-neo-tree/neo-tree.nvim" },
	{ src = "https://github.com/MunifTanjim/nui.nvim" }, -- dependent for neo-tree

	-- overseer
	{ src = "https://github.com/stevearc/overseer.nvim" },

	-- cph from bcyz
	{ src = "https://github.com/beicanzhuzhu/cph.nvim" },

	-- dap and dap-ui
	{ src = "https://codeberg.org/mfussenegger/nvim-dap.git" },
	{ src = "https://github.com/nvim-neotest/nvim-nio" }, -- dependent for nvim-dap-ui
	{ src = "https://github.com/rcarriga/nvim-dap-ui" },
	{ src = "https://github.com/thehamsta/nvim-dap-virtual-text" },
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
-- require("plugins.toggleterm") -- lazy loaded
-- require("plugins.oil")
-- require("plugins.neo-tree") -- lazy loaded
require("plugins.nvim-ufo")
require("plugins.todo-comments")
require("plugins.blink-indent")
require("plugins.nvim-notify")
require("plugins.flash")
-- require("plugins.mini-files")
require("plugins.multicursor-nvim")
-- require("plugins.mini-indentscope")
-- require("plugins.overseer") -- lazy loaded

-- 使用lazy加载器
local lazy = require("utlis.lazy")

-- 在使用命令的时候懒加载插件

lazy.map("<leader>t", "toggleterm", "plugins.toggleterm", { noremap = true, silent = true, desc = "ToggleTerm float" })

lazy.map("<leader>e", "neo-tree", "plugins.neo-tree", { silent = true, desc = " Neotree toggle" })

lazy.map("<leader>oo", "overseer", "plugins.overseer", { desc = "Overseer: toggle task list" })
lazy.map("<leader>ot", "overseer", "plugins.overseer", { desc = "Overseer: run task" })
lazy.map("<leader>os", "overseer", "plugins.overseer", { desc = "Overseer: shell task" })
lazy.map("<leader>oa", "overseer", "plugins.overseer", { desc = "Overseer: task action" })

lazy.map("<leader>x", "cph", "plugins.cph", { silent = true, desc = " CPH toggle" })

lazy.map("<F5>", "dap", "plugins.dap", { desc = "DAP Continue" })
lazy.map("<leader>dn", "dap", "plugins.dap", { desc = "DAP Step Over" })
lazy.map("<leader>di", "dap", "plugins.dap", { desc = "DAP Step Into" })
lazy.map("<leader>do", "dap", "plugins.dap", { desc = "DAP Step Out" })
lazy.map("<Leader>b", "dap", "plugins.dap", { desc = "DAP Toggle Breakpoint" })
lazy.map("<Leader>dq", "dap", "plugins.dap", { desc = "DAP Quit" })
