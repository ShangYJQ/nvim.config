---@brief
---
--- https://github.com/mathworks/MATLAB-language-server
---
--- MATLAB® language server implements the Microsoft® Language Server Protocol for the MATLAB language.
---
--- Make sure to set `MATLAB.installPath` to your MATLAB path, e.g.:
--- ```lua
--- settings = {
---   MATLAB = {
---     ...
---     installPath = '/usr/local/MATLAB/R2023a',
---     ...
---   },
--- },
--- ```

---@type vim.lsp.Config
return {
	-- cmd = { "matlab-language-server", "--stdio" },
	-- NOTE: Use you why to start matlab_ls
	cmd = {
		"bun",
		"/Users/yjq/Documents/code/github/MATLAB-language-server/out/index.js",
		"--stdio",
	},

	filetypes = { "matlab" },
	root_dir = function(bufnr, on_dir)
		local root_dir = vim.fs.root(bufnr, ".git")
		on_dir(root_dir or vim.fn.getcwd())
	end,
	settings = {
		MATLAB = {
			indexWorkspace = true,
			-- NOTE: Set this to your MATLAB installation path.
			installPath = "/Applications/MATLAB_R2025b.app",
			matlabConnectionTiming = "onStart",
			telemetry = true,
		},
	},
}
