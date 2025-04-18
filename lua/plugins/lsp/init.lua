local lsp_server = {
    lua_ls = {},
    clangd = {
        cmd = {
            "clangd",
            "--query-driver=**",
            "--header-insertion=never",
            "--clang-tidy",
            "--background-index",
            "--completion-style=detailed"
        }
    },
    html = {},
    pyright = {},
    cmake = {},
}

return {
    "williamboman/mason.nvim",
    "williamboman/mason-lspconfig.nvim",
    {
        'saghen/blink.cmp',
        -- optional: provides snippets for the snippet source
        dependencies = 'rafamadriz/friendly-snippets',

        version = '*',
        opts = {
            keymap     = {
                preset = 'none',

                ['<C-space>'] = { 'show', 'show_documentation', 'hide_documentation' },
                ['<cr>'] = { 'accept', 'fallback' },

                ['C-Down'] = { 'scroll_documentation_down', 'fallback' },
                ['C-Up'] = { 'scroll_documentation_up', 'fallback' },

                ['<Tab>'] = { 'snippet_forward', 'fallback' },
                ['<S-Tab>'] = { 'snippet_backward', 'fallback' },

                ['<Up>'] = { 'select_prev', 'fallback' },
                ['<Down>'] = { 'select_next', 'fallback' },

            },
            cmdline    = {
                keymap = {
                    preset = 'none',
                    ['<Tab>'] = {
                        function(cmp)
                            if cmp.is_ghost_text_visible() and not cmp.is_menu_visible() then return cmp.accept() end
                        end,
                        'show_and_insert',
                        'select_next',
                    },
                    ['<S-Tab>'] = { 'show_and_insert', 'select_prev' },

                    ['<C-n>'] = { 'select_and_accept' },
                    ['<C-e>'] = { 'cancel' },
                }
            },

            appearance = {
                use_nvim_cmp_as_default = true,
                nerd_font_variant = 'mono'
            },
            completion = {
                list = { selection = { preselect = false, auto_insert = true } },
                menu = {
                    border = 'single',
                    draw = {
                        columns = {
                            { "label",     "label_description", gap = 1 },
                            { "kind_icon", "kind" }
                        }
                    },
                },
                documentation = {
                    window = { border = 'single', },
                    auto_show = true,
                    auto_show_delay_ms = 500,
                },
                ghost_text = { enabled = true },
            },
            signature  = { window = { border = 'single' } },
            sources    = {
                default = { 'lsp', 'path', 'snippets', 'buffer', 'markdown' },
                providers = {
                    markdown = {
                        name = 'RenderMarkdown',
                        module = 'render-markdown.integ.blink',
                        fallbacks = { 'lsp' },
                    },
                },
            },
        },

        opts_extend = { "sources.default" }
    },
    {
        'neovim/nvim-lspconfig',
        dependencies = { 'saghen/blink.cmp' },

        -- example using `opts` for defining servers
        opts = {
            servers = lsp_server
        },
        config = function(_, opts)
            local lspconfig = require('lspconfig')
            for server, config in pairs(opts.servers) do
                -- passing config.capabilities to blink.cmp merges with the capabilities in your
                -- `opts[server].capabilities, if you've defined it
                config.capabilities = require('blink.cmp').get_lsp_capabilities(config.capabilities)
                lspconfig[server].setup(config)
            end
        end

        --   -- example calling setup directly for each LSP
        --   config = function()
        --     local capabilities = require('blink.cmp').get_lsp_capabilities()
        --     local lspconfig = require('lspconfig')

        --     lspconfig['lua_ls'].setup({ capabilities = capabilities })
        --   end
    },

    {
        "folke/lazydev.nvim",
        ft = "lua", -- only load on lua files
        opts = {
            library = {
                -- See the configuration section for more details
                -- Load luvit types when the `vim.uv` word is found
                { path = "${3rd}/luv/library", words = { "vim%.uv" } },
            },
        },
    },

}
