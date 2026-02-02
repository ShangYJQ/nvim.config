-- mini file
require("mini.files").setup({})

local map = vim.keymap.set
-- mini files
map("n", "<leader>e", function()
	require("mini.files").open()
end)
