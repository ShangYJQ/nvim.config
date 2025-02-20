return {
  {
    'saghen/blink.cmp',
    -- optional: provides snippets for the snippet source
    dependencies = 'rafamadriz/friendly-snippets',

    -- use a release tag to download pre-built binaries
    version = '*',
    opts = {
      keymap = {
        preset = 'none',
        ['<C-space>'] = { 'show', 'show_documentation', 'hide_documentation' },
        ['<cr>'] = { 'accept', 'fallback' },

        -- ['<S-Tab>'] = { 'select_prev', 'fallback' },
        -- ['<Tab>'] = { 'select_next', 'fallback' },

        ['<C-b>'] = { 'scroll_documentation_up', 'fallback' },
        ['<C-f>'] = { 'scroll_documentation_down', 'fallback' },

        ['Down'] = { 'scroll_documentation_down', 'fallback' },
        ['Up'] = { 'scroll_documentation_up', 'fallback' },

        ['<Tab>'] = { 'snippet_forward', 'fallback' },
        ['<S-Tab>'] = { 'snippet_backward', 'fallback' },

        ['<Up>'] = { 'select_prev', 'fallback' },
        ['<Down>'] = { 'select_next', 'fallback' },

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
      signature = { window = { border = 'single' } },
      -- Default list of enabled providers defined so that you can extend it
      -- elsewhere in your config, without redefining it, due to `opts_extend`
      sources = {
        default = { 'lsp', 'path', 'snippets', 'buffer' },
      },
    },

    opts_extend = { "sources.default" }
  },
  {
    'neovim/nvim-lspconfig',
    dependencies = { 'saghen/blink.cmp' },

    -- example using `opts` for defining servers
    opts = {
      servers = {
        lua_ls = {},
        clangd = {},
        pyright = {},
      }
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
  }

}
