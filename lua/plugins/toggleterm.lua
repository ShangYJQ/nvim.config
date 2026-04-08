require("toggleterm").setup({
	direction = "float",
	float_opts = {
		border = "rounded",
		width = 90,
		height = 28,
		winblend = 0,
	},
})

local map = vim.keymap.set

map("n", "<leader>t", "<cmd>ToggleTerm direction=float<CR>", { noremap = true, silent = true })
-- map("n", "<leader>tb", "<cmd>ToggleTerm direction=tab<CR>", { noremap = true, silent = true })
