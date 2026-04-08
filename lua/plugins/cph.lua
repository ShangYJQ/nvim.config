require("cph").setup({
	window = {
		dir = "floating",
		width = 90,
		height = 28,
	},
	compile = {
		cpp = {
			compiler = "clang++",
			arg = "-O2 -std=c++20",
		},
		c = {
			compiler = "clang",
			arg = "-O2",
		},
	},
	run = {
		time_limit = 2000,
		memory_limit = 2048,
	},
})

local map = vim.keymap.set

map("n", "<leader>x", "<Cmd>ToggleCPH<CR>", { silent = true, desc = " CPH toggle" })
