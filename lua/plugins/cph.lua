require("cph").setup({
	window = {
		dir = "right",
		width = 34,
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
		time_limit = 4000,
		memory_limit = 8000,
	},
})

local map = vim.keymap.set

map("n", "<leader>x", "<Cmd>ToggleCPH<CR>", { silent = true, desc = " CPH toggle" })
