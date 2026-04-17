vim.api.nvim_set_hl(0, "TinyCmdlineNormal", { link = "NormalFloat" })
vim.api.nvim_set_hl(0, "TinyCmdlineBorder", { link = "FloatBorder" })

require("tiny-cmdline").setup({
	-- Cmdline window width
	width = {
		value = "60%", -- "N%" = fraction of editor columns, integer = absolute columns
		min = 40, -- minimum width in columns
		max = 80, -- maximum width in columns
	},

	-- Window position ("N%" = fraction of available space, integer = absolute columns/rows)
	position = {
		x = "50%", -- horizontal: "0%" = left, "50%" = center, "100%" = right
		y = "60%", -- vertical:   "0%" = top,  "50%" = center, "100%" = bottom
	},

	-- Border style for the floating window
	-- nil inherits vim.o.winborder at setup() time, falling back to "rounded"
	-- Set to "none" to disable the border
	border = nil,

	-- Horizontal offset of the completion menu anchor from the window's left inner edge
	-- Used to align blink.cmp / nvim-cmp menus with the cmdline window
	menu_col_offset = 3,

	-- Cmdline types rendered at the bottom of the screen instead of centered
	-- "/" and "?" (search) are kept native by default
	native_types = { "/", "?" },

	-- Optional callback invoked after every reposition
	on_reposition = require("tiny-cmdline").adapters.blink,
})
