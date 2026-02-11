local map = vim.keymap.set

map({ "n", "x" }, "s", function()
	require("flash").jump()
end, { desc = "flash jump" })

map("n", "S", function()
	require("flash").treesitter()
end, { desc = "flash treesitter select" })
