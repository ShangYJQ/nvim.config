-- Tiny-inline-diagnostic (prettier diagnostic display)
require("tiny-inline-diagnostic").setup({
	preset = "modern",
	transparent_bg = true,
	transparent_cursorline = true,
})

-- 用 tiny-inline-diagnostic 的浮窗替换内置诊断浮窗（只需执行一次）
vim.diagnostic.open_float = require("tiny-inline-diagnostic.override").open_float

local map = vim.keymap.set

map("n", "<leader>id", function()
	require("tiny-inline-diagnostic").toggle()
end, { desc = "Toggle inline diagnostic" })
