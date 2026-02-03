local lsp_servers = {
	"lua_ls",
	"rust_analyzer",
	"clangd",
	"ruff",
	"bashls",
	"jsonls",
	"gopls",
	"zls",
	"unocss",
	"dockerls",
	"vtsls",
}

-- you need have vue-language-server exe in your PATH !
-- try pacman -S vue-language-server
local vue_language_server_path = vim.fn.exepath("vue-language-server")

local vue_plugin = {
	name = "@vue/typescript-plugin",
	location = vue_language_server_path,
	languages = { "vue" },
	configNamespace = "typescript",
}

vim.lsp.config("vtsls", {
	settings = {
		vtsls = {
			tsserver = {
				globalPlugins = {
					vue_plugin,
				},
			},
		},
	},
	filetypes = { "typescript", "javascript", "javascriptreact", "typescriptreact", "vue" },
})

-- 按需加载Vue语言服务器配置
vim.api.nvim_create_autocmd("FileType", {
	pattern = "vue",
	callback = function()
		vim.lsp.enable("vue_ls")
	end,
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
