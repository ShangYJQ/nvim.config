local map = vim.keymap.set
-- multi cursors
local mc = require("multicursor-nvim")
mc.setup()

map({ "n", "x" }, "<S-c>", function()
	mc.lineAddCursor(1)
end)
map({ "n", "x" }, "<leader><S-c>", function()
	mc.lineSkipCursor(1)
end)
map({ "n", "x" }, "<leader>m", function()
	mc.clearCursors()
end)
