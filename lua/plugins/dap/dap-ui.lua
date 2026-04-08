-- for dap breakpoints icon
vim.fn.sign_define("DapBreakpoint", {
	text = "󰧞",
	texthl = "DapBreakpoint",
})
vim.api.nvim_set_hl(0, "DapBreakpoint", { fg = "#e06c75" })

---@diagnostic disable-next-line: missing-fields
require("dapui").setup({
	controls = {
		element = "repl",
		enabled = true,
		icons = {
			disconnect = "",
			pause = "",
			play = "",
			run_last = "",
			step_back = "",
			step_into = "",
			step_out = "",
			step_over = "",
			terminate = "",
		},
	},
	element_mappings = {},
	expand_lines = true,
	floating = {
		border = "single",
		mappings = {
			close = { "q", "<Esc>" },
		},
	},
	force_buffers = true,
	icons = {
		collapsed = "",
		current_frame = "",
		expanded = "",
	},
	layouts = {
		{
			elements = {
				{
					id = "scopes",
					size = 0.38,
				},
				{
					id = "breakpoints",
					size = 0.15,
				},
				{
					id = "stacks",
					size = 0.15,
				},
				{
					id = "watches",
					size = 0.32,
				},
			},
			position = "left",
			size = 32,
		},
		{
			elements = {
				{
					id = "repl",
					size = 0.6,
				},
				{
					id = "console",
					size = 0.4,
				},
			},
			position = "bottom",
			size = 10,
		},
	},
	mappings = {
		edit = "e",
		expand = { "<CR>", "<2-LeftMouse>" },
		open = "o",
		remove = "d",
		repl = "r",
		toggle = "t",
	},
	render = {
		indent = 1,
		max_value_lines = 100,
	},
})
