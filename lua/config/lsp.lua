-- Lsp servers
local lsp_servers = { "lua_ls", "rust_analyzer", "clangd", "ruff", "bashls", "jsonls", "gopls" }

vim.filetype.add({
	extension = {
		gowork = "gowork",
		gotmpl = "gotmpl",
	},
})

vim.diagnostic.config({
	signs = {
		text = {
			[vim.diagnostic.severity.ERROR] = " ",
			[vim.diagnostic.severity.WARN] = " ",
			[vim.diagnostic.severity.INFO] = " ",
			[vim.diagnostic.severity.HINT] = " ",
		},
	},
})

vim.api.nvim_create_autocmd("BufReadPost", {
	once = true,
	callback = function()
		vim.lsp.enable(lsp_servers)
	end,
})
