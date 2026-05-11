local lsp_servers = {
	"lua_ls",
	"rust_analyzer",
	"clangd",
	"basedpyright",
	"bashls",
	"jsonls",
	"gopls",
	"zls",
	"unocss",
	"tailwindcss",
	"dockerls",
	"eslint",
	"vue_ls",
	"vtsls",
	"neocmake",
	-- "sqls",
	"fish_lsp",
	"nixd",
	"asm_lsp",
	"hls",
	"elixirls",
	"taplo",
	"matlab_ls",
	"gh_actions_ls",
	"make_ls",
}

-- you need have vue-language-server exe in your PATH !
local vue_language_server_path = vim.fn.exepath("vue-language-server")

local vue_plugin = {
	name = "@vue/typescript-plugin",
	location = vue_language_server_path,
	languages = { "vue" },
	configNamespace = "typescript",
}

vim.lsp.config("clangd", {
	cmd = {
		"clangd",
		"--background-index",
		"--clang-tidy",
	},
})

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

vim.lsp.config("tailwindcss", {
	-- filetypes copied and adjusted from tailwindcss-intellisense
	filetypes = {
		-- html
		"aspnetcorerazor",
		"astro",
		"astro-markdown",
		"blade",
		"clojure",
		"django-html",
		"htmldjango",
		"edge",
		"eelixir", -- vim ft
		"elixir",
		"ejs",
		"erb",
		"eruby", -- vim ft
		"gohtml",
		"gohtmltmpl",
		"haml",
		"handlebars",
		"hbs",
		"html",
		"htmlangular",
		"html-eex",
		"heex",
		"jade",
		"leaf",
		"liquid",
		-- "markdown",
		"mdx",
		"mustache",
		"njk",
		"nunjucks",
		"php",
		"razor",
		"slim",
		"twig",
		-- css
		"css",
		"less",
		"postcss",
		"sass",
		"scss",
		"stylus",
		"sugarss",
		-- js
		"javascript",
		"javascriptreact",
		"reason",
		"rescript",
		"typescript",
		"typescriptreact",
		-- mixed
		"vue",
		"svelte",
		"templ",
	},
})

-- sqls 的配置
-- 在打开目录下创建 config.yml
-- connections:
--   - alias: local_pg
--     driver: postgresql
--     dataSourceName: "host=/run/postgresql user=xxx dbname=xxx sslmode=disable"
-- vim.lsp.config("sqls", {
-- 	cmd = { "sqls", "-config", "config.yml" },
-- })

-- Emmet 服务器
-- vim.api.nvim_create_autocmd("FileType", {
-- 	pattern = { "vue", "html" },
-- 	callback = function()
-- 		vim.lsp.enable("emmet_language_server")
-- 	end,
-- })

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

vim.lsp.enable(lsp_servers)
