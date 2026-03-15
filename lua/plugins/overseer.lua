local overseer = require("overseer")

overseer.setup({
	-- Patch nvim-dap to support preLaunchTask and postDebugTask
	dap = false,
	-- Configure the task output buffer and window
	output = {
		-- Use a terminal buffer to display output. If false, a normal buffer is used
		use_terminal = true,
		-- If true, don't clear the buffer when a task restarts
		preserve_output = false,
	},
	-- Configure the task list
	task_list = {
		-- Default direction. Can be "left", "right", or "bottom"
		direction = "bottom",
		-- Width dimensions can be integers or a float between 0 and 1 (e.g. 0.4 for 40%)
		-- min_width and max_width can be a single value or a list of mixed integer/float types.
		-- max_width = {100, 0.2} means "the lesser of 100 columns or 20% of total"
		max_width = { 100, 0.2 },
		-- min_width = {40, 0.1} means "the greater of 40 columns or 10% of total"
		min_width = { 40, 0.1 },
		max_height = { 20, 0.2 },
		min_height = 8,
		-- Set keymap to false to remove default behavior
		-- You can add custom keymaps here as well (anything vim.keymap.set accepts)
		keymaps = {
			["?"] = "keymap.show_help",
			["g?"] = "keymap.show_help",
			["<CR>"] = "keymap.run_action",
			["dd"] = { "keymap.run_action", opts = { action = "dispose" }, desc = "Dispose task" },
			["<C-e>"] = { "keymap.run_action", opts = { action = "edit" }, desc = "Edit task" },
			["o"] = "keymap.open",
			["<C-v>"] = { "keymap.open", opts = { dir = "vsplit" }, desc = "Open task output in vsplit" },
			["<C-s>"] = { "keymap.open", opts = { dir = "split" }, desc = "Open task output in split" },
			["<C-t>"] = { "keymap.open", opts = { dir = "tab" }, desc = "Open task output in tab" },
			["<C-f>"] = { "keymap.open", opts = { dir = "float" }, desc = "Open task output in float" },
			["<C-q>"] = {
				"keymap.run_action",
				opts = { action = "open output in quickfix" },
				desc = "Open task output in the quickfix",
			},
			["p"] = "keymap.toggle_preview",
			["{"] = "keymap.prev_task",
			["}"] = "keymap.next_task",
			["<C-k>"] = false,
			["<C-j>"] = false,
			["<C-Up>"] = "keymap.scroll_output_up",
			["<C-Down>"] = "keymap.scroll_output_down",
			["g."] = "keymap.toggle_show_wrapped",
			["q"] = { "<CMD>close<CR>", desc = "Close task list" },
		},
	},
	log_level = vim.log.levels.WARN,

	-- Overseer can wrap any call to vim.system and vim.fn.jobstart as a task.
	experimental_wrap_builtins = {
		enabled = false,
		condition = function(cmd, caller, opts)
			return true
		end,
	},
})

local map = vim.keymap.set

-- map("n", "<leader>ot", "<cmd>OverseerToggle<cr>", { desc = "Overseer: toggle task list" })
map("n", "<leader>oo", function()
	overseer.toggle({ enter = false, direction = "bottom" })
end, { desc = "Overseer: toggle task list" })

map("n", "<leader>or", function()
	overseer.run_task()
end, { desc = "Overseer: run task" })

map("n", "<leader>os", "<cmd>OverseerShell<cr>", { desc = "Overseer: shell task" })
map("n", "<leader>oa", "<cmd>OverseerTaskAction<cr>", { desc = "Overseer: task action" })
