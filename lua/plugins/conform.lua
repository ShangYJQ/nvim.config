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
		taplo = {
			prepend_args = { "format", "-", "--option", "indent_string=\t" },
		},
		prettier = {
			prepend_args = {
				"--use-tabs",
			},
		},
	},

	formatters_by_ft = {
		c = { "clang_format" },
		cpp = { "clang_format" },
		json = { "prettier" },
		jsonc = { "prettier" },
		lua = { "stylua" },
		rust = { "rustfmt", lsp_format = "fallback" },
		python = { "ruff_format" },
		go = { "goimports", "gofmt" },
		zig = { "zigfmt" },
		zsh = { "shfmt" },
		sh = { "shfmt" },
		bash = { "shfmt" },
		toml = { "taplo" },
		cmake = { "cmake_format" },
		vue = { "prettier" },
		markdown = { "prettier" },
		yaml = { "prettier" },
		html = { "prettier" },
		css = { "prettier" },
		svg = { "prettier" },
		xml = { "prettier" },
	},
})
