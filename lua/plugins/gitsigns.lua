-- gitsigns
require("gitsigns").setup({
	-- signcolumn = false,
	-- numhl = true,

	signs = {
		add = { text = "┃" },
		change = { text = "┃" },
		delete = { text = "_" },
		topdelete = { text = "‾" },
		changedelete = { text = "~" },
		untracked = { text = "┆" },
	},
	signs_staged = {
		add = { text = "┃" },
		change = { text = "┃" },
		delete = { text = "_" },
		topdelete = { text = "‾" },
		changedelete = { text = "~" },
		untracked = { text = "┆" },
	},

	current_line_blame = true,
	current_line_blame_opts = {
		delay = 500,
		virt_text_pos = "eol",
	},
})

local map = vim.keymap.set
local gitsigns = require("gitsigns")

-- Navigation
map("n", "]c", function()
	if vim.wo.diff then
		vim.cmd.normal({ "]c", bang = true })
	else
		gitsigns.nav_hunk("next")
	end
end, { desc = "Go to next git hunk" })

map("n", "[c", function()
	if vim.wo.diff then
		vim.cmd.normal({ "[c", bang = true })
	else
		gitsigns.nav_hunk("prev")
	end
end, { desc = "Go to prev git hunk" })

-- Toggle git blame
vim.keymap.set("n", "<leader>ig", function()
	require("gitsigns").toggle_current_line_blame()
end, { desc = "Toggle git blame" })

-- show diff hunk inline
map("n", "<leader>gd", gitsigns.preview_hunk_inline, { desc = "Inline preview" })
