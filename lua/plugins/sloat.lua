require("sloat").setup({
	float = {
		width = 0.7,
		height = 0.72,
		border = "rounded",
	},
	bottom = {
		height = 20,
	},
})

local map = vim.keymap.set

map("n", "<leader>t", "<cmd>Sloat float<CR>", { noremap = true, silent = true, desc = "Toggle sloat term" })
