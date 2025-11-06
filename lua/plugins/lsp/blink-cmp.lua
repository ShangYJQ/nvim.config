return {
    'saghen/blink.cmp',
    -- optional: provides snippets for the snippet source
    dependencies = 'rafamadriz/friendly-snippets',

    version = '1.*',
    --- @module 'blink.cmp'
    --- @type blink.cmp.Config

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
            list = { selection = { preselect = true, auto_insert = false } },
            documentation = {
                auto_show = true,
                auto_show_delay_ms = 300,
                window = { border = 'single' },
            },
            menu = {
                border = 'single',
                draw = {
                    columns = {
                        { "kind_icon" },
                        { "label",    "label_description", gap = 1 },
                    },
                    components = {
                        kind_icon = {
                            text = function(ctx)
                                local kind_icon, _, _ = require('mini.icons').get('lsp', ctx.kind)
                                return kind_icon
                            end,
                            -- (optional) use highlights from mini.icons
                            highlight = function(ctx)
                                local _, hl, _ = require('mini.icons').get('lsp', ctx.kind)
                                return hl
                            end,
                        },
                    }
                },
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
        fuzzy      = { implementation = "prefer_rust" },
    },
    opts_extend = { "sources.default" }
}
