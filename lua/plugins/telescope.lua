-- Telescope set

local actions = require("telescope.actions")

require("telescope").setup({
	defaults = {
		layout_strategy = "horizontal",
		sorting_strategy = "ascending",
		file_ignore_patterns = {
			"node_modules/",
			"%.git/",
			"build.*/",
		},
		layout_config = {
			prompt_position = "top",
			width = 0.9,
			height = 0.9,

			preview_width = 0.5,
		},

		-- Default configuration for telescope goes here:
		-- config_key = value,
		mappings = {
			i = {
				-- map actions.which_key to <C-h> (default: <C-/>)
				-- actions.which_key shows the mappings for your picker,
				-- e.g. git_{create, delete, ...}_branch for the git_branches picker
				["<C-j>"] = actions.move_selection_next,
				["<C-k>"] = actions.move_selection_previous,
				["<C-l>"] = actions.select_default,
			},
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
-- require("telescope").load_extension("project")

local map = vim.keymap.set

-- Telescope
local builtin = require("telescope.builtin")
map("n", "<leader>f", builtin.find_files, { desc = "Telescope find files" })
map("n", "<leader>/", builtin.current_buffer_fuzzy_find, { desc = "Telescope current buffer fuzzy find" })
map("n", "<leader>?", builtin.live_grep, { desc = "Telescope live grep" })
-- map("n", "<leader>b", builtin.buffers, { desc = "Telescope buffers" })
-- map("n", "<leader>th", builtin.help_tags, { desc = "Telescope help tags" })
map("n", "<leader>D", builtin.diagnostics, { desc = "Telescope diagnostics" })
map("n", "<leader>s", builtin.lsp_document_symbols, { desc = "Telescope lsp_document_symbols" })
map("n", "<leader>S", builtin.lsp_workspace_symbols, { desc = "Telescope lsp_workspace_symbols" })
map("n", "<leader>gh", builtin.git_status, { desc = "Telescope git status" })

-- TodoTelescope
-- What to do?
map("n", "<leader>w", "<cmd>TodoTelescope<CR>", { desc = "Telescope find tode" })

-- Projects telescope
-- map("n", "<leader>p", function()
-- 	require("telescope").extensions.project.project({})
-- end, { desc = "Telescope projects" })

-- theme switcher
map("n", "<leader>T", function()
	builtin.colorscheme({
		enable_preview = true,
	})
end, { desc = "switcher theme" })

map("n", "<leader>n", "<cmd>Telescope notify<CR>", { desc = "Telescope notify" })
