return {
	name = "Python quick run",
	builder = function()
		local file = vim.fn.expand("%:p")

		return {
			cmd = {
				"python3",
				file,
			},
			components = {
				{
					"open_output",
					direction = "float",
					focus = true,
					on_start = "always",
					on_complete = "never",
				},
				"on_exit_set_status",
				"on_complete_dispose",
			},
		}
	end,
	condition = {
		filetype = { "python" },
	},
}
