return {
	name = "Debug build",
	builder = function()
		local file = vim.fn.expand("%:p")
		local filename = vim.fn.expand("%:t:r")
		local ext = vim.fn.expand("%:e")
		local cwd = vim.fn.getcwd()
		local out_dir = cwd .. "/.output"
		local exe = out_dir .. "/" .. filename

		local compile_cmd
		if ext == "c" then
			compile_cmd = "mkdir -p '" .. out_dir .. "' && clang '" .. file .. "' -std=c17 -g -O0 -o '" .. exe .. "'"
		else
			compile_cmd = "mkdir -p '"
				.. out_dir
				.. "' && clang++ '"
				.. file
				.. "' -std=c++23 -g -O0 -o '"
				.. exe
				.. "'"
		end

		return {
			cmd = { "bash" },
			args = {
				"-c",
				compile_cmd,
			},
			components = {
				{ "on_output_quickfix", open = false },
				"on_result_diagnostics",
				"default",
			},
			metadata = {
				exe = exe,
			},
		}
	end,
	condition = {
		filetype = { "c", "cpp" },
	},
}
