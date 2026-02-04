-- Telescope set
require("telescope").setup({
	defaults = {
		layout_strategy = "horizontal",
		sorting_strategy = "ascending",
		layout_config = {
			prompt_position = "top",
			width = 0.9,
			height = 0.9,

			preview_width = 0.5,
		},
	},
	extensions = {
		fzf = {
			fuzzy = true,
			override_generic_sorter = true,
			override_file_sorter = true,
			case_mode = "smart_case",
		},
	},
})
require("telescope").load_extension("fzf")

local map = vim.keymap.set

-- Telescope
local builtin = require("telescope.builtin")
map("n", "<leader>f", builtin.find_files, { desc = "Telescope find files" })
map("n", "<leader>/", builtin.live_grep, { desc = "Telescope live grep" })
map("n", "<leader>b", builtin.buffers, { desc = "Telescope buffers" })
map("n", "<leader>th", builtin.help_tags, { desc = "Telescope help tags" })
map("n", "<leader>d", builtin.diagnostics, { desc = "Telescope diagnostics" })
map("n", "<leader>s", builtin.lsp_document_symbols, { desc = "Telescope lsp_document_symbols" })
map("n", "<leader>S", builtin.lsp_workspace_symbols, { desc = "Telescope lsp_workspace_symbols" })

-- TodoTelescope
map("n", "<leader>p", "<cmd>TodoTelescope<CR>", { desc = "Telescope find tode" })

-- theme switcher
map("n", "<leader>T", function()
	builtin.colorscheme({
		enable_preview = true,
	})
end, { desc = "switcher theme" })
