local ts = require("ts-install")

ts.setup({
	auto_install = true,
	auto_update = true,

	ensure_install = {
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
		"dart",
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
	},
})

-- 自动启用 Treesitter 高亮
vim.api.nvim_create_autocmd("FileType", {
	group = vim.api.nvim_create_augroup("TSHighlight", {
		clear = true,
	}),
	pattern = "*",
	callback = function(ev)
		pcall(vim.treesitter.start, ev.buf)
	end,
})
