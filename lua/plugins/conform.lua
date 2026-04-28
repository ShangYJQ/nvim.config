-- Conform
require("conform").setup({
	format_on_save = { timeout_ms = 2000, lsp_format = "fallback" },

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

	---@type table<string, conform.FiletypeFormatter>
	formatters_by_ft = {

		-- oxfmt
		json = { "oxfmt" },
		jsonc = { "oxfmt" },
		json5 = { "oxfmt" },
		toml = { "oxfmt" },
		vue = { "oxfmt" },
		markdown = { "oxfmt" },
		yaml = { "oxfmt" },
		yml = { "oxfmt" },
		html = { "oxfmt" },
		css = { "oxfmt" },

		-- clang_format
		c = { "clang_format" },
		cpp = { "clang_format" },
		cmake = { "cmake_format" },

		-- xmllint
		xml = { "xmllint" },
		svg = { "xmllint" },

		-- stylua
		lua = { "stylua" },

		-- rustfmt
		rust = { "rustfmt", lsp_format = "fallback" },

		-- ruff_format
		python = { "ruff_format" },

		-- go
		go = { "goimports", "gofmt" },

		-- zigfmt
		zig = { "zigfmt" },

		-- shfmt
		zsh = { "shfmt" },
		sh = { "shfmt" },
		bash = { "shfmt" },

		-- ormolu
		haskell = { "ormolu" },
	},
})
