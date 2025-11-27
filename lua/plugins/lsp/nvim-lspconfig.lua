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
    basedpyright = {},
    cmake = {},
    rust_analyzer = {},
}

return {
    {
        'neovim/nvim-lspconfig',
        dependencies = { 'saghen/blink.cmp' },

        -- example using `opts` for defining servers
        opts = { servers = lsp_server },
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
    }
}
