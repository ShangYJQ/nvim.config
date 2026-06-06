require("tree-sitter-manager").setup({

	nerdfont = true,

	-- Default Options
	ensure_installed = {
		"html",
		"css",
		"vim",
		"vue",
		"vimdoc",
		"lua",
		"dockerfile",
		"javascript",
		"typescript",
		"tsx",
		"python",
		"cpp",
		"c",
		"bash",
		"make",
		"markdown",
		"markdown_inline",
		"matlab",
		"rust",
		"json",
		"toml",
		"cmake",
		"go",
		"gowork",
		"gotmpl",
		"gomod",
		"graphql",
		"git_config",
		"git_rebase",
		"gitcommit",
		"gitignore",
		"query",
		"zsh",
		"zig",
		"yaml",
		"haskell",
	}, -- list of parsers to install at the start of a neovim session. If set to "all", install all parsers.
	border = "single", -- border style for the window (e.g. "rounded", "single"), if nil, use the default border style defined by 'vim.o.winborder'. See :h 'winborder' for more info.
	auto_install = false, -- if enabled, install missing parsers when editing a new file
	highlight = true, -- treesitter highlighting is enabled by default
	-- languages = {}, -- override or add new parser sources
})
