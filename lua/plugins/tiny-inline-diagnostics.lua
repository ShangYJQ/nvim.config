-- Tiny-inline-diagnostic (prettier diagnostic display)
require("tiny-inline-diagnostic").setup({
	preset = "modern",
	transparent_bg = true,
	transparent_cursorline = true,
})

local map = vim.keymap.set

map("n", "<leader>id", function()
	require("tiny-inline-diagnostic").toggle()
end, { desc = "Toggle inline diagnostic" })
