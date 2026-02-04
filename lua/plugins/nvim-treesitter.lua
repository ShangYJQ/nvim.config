local ts = require("nvim-treesitter")

ts.setup({
	install_dir = vim.fn.stdpath("data") .. "/site",
})

-- 安装解析器
ts.install({
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
	"zsh",
	"zig",
	"yaml",
})

-- 自动启用ts高亮
vim.api.nvim_create_autocmd("FileType", {
	group = vim.api.nvim_create_augroup("TSHighlight", { clear = true }),
	callback = function(ev)
		local ignore = { "checkhealth", "lazy", "vim", "help" }
		if vim.tbl_contains(ignore, vim.bo[ev.buf].filetype) then
			return
		end
		pcall(vim.treesitter.start, ev.buf)
	end,
})
