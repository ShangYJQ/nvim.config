-- Conform
require("conform").setup({
	format_on_save = { timeout_ms = 500, lsp_format = "fallback" },

	formatters = {
		clang_format = {
			prepend_args = {
				"--style={BasedOnStyle: LLVM, IndentWidth: 4, UseTab: Always, TabWidth: 4}",
			},
		},
		rustfmt = {
			args = { "--edition", "2021", "--config", "hard_tabs=true,tab_spaces=4", "--emit", "stdout" },
		},
	},

	formatters_by_ft = {
		c = { "clang_format" },
		cpp = { "clang_format" },
		json = { "clang_format" },
		lua = { "stylua" },
		rust = { "rustfmt", lsp_format = "fallback" },
		python = { "ruff_format" },
		go = { "goimports", "gofmt" },
	},
})
