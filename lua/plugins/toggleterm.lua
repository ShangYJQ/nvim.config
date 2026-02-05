require("toggleterm").setup({
	direction = "float",
	float_opts = {
		border = "curved",
		width = 130,
		height = 30,
		winblend = 0,
	},
})

local map = vim.keymap.set

map("n", "<leader>tt", "<cmd>ToggleTerm direction=float<CR>", { noremap = true, silent = true })
map("n", "<leader>tb", "<cmd>ToggleTerm direction=tab<CR>", { noremap = true, silent = true })
