-- Blink.cmp(autocompletion)

local cmp = require("blink.cmp")

cmp.build():wait(60000)

cmp.setup({
	enabled = function()
		-- :set buftype?
		-- :set filetype?
		local ft = vim.bo.filetype
		local bt = vim.bo.buftype

		-- disable for dapui
		if ft:match("^dap%-") then
			return false
		end

		-- 所有 nofile 都不开启
		if bt ~= "" then
			return false
		end

		return true
	end,
	keymap = {
		preset = "enter",
		["<C-h>"] = { "show", "show_documentation", "hide_documentation" },
		["<CR>"] = { "accept", "fallback" },
		["<C-l>"] = { "accept", "fallback" },
		["<C-Down>"] = { "scroll_documentation_down", "fallback" },
		["<C-Up>"] = { "scroll_documentation_up", "fallback" },
		["<Tab>"] = { "snippet_forward", "fallback" },
		["<S-Tab>"] = { "snippet_backward", "fallback" },
		["<C-k>"] = { "select_prev", "fallback" },
		["<C-j>"] = { "select_next", "fallback" },
		-- ["<Up>"] = {},
		-- ["<Down>"] = {},
		-- ["<C-n>"] = { "select_next", "fallback" },
		-- ["<C-p>"] = { "select_prev", "fallback" },
		["<C-e>"] = { "hide", "fallback" },
	},

	fuzzy = { implementation = "prefer_rust_with_warning" },

	snippets = { preset = "default" },

	completion = {
		documentation = {
			auto_show = false,
			auto_show_delay_ms = 800,
		},
		ghost_text = { enabled = true },
	},

	cmdline = {
		completion = { menu = { auto_show = false } },
		keymap = {
			-- ["<Tab>"] = {},
			-- ["<S-Tab>"] = {},

			["<C-l>"] = { "accept", "fallback" },
			["<CR>"] = { "accept_and_enter", "fallback" },

			["<C-k>"] = { "select_prev", "fallback" },
			["<C-j>"] = { "select_next", "fallback" },
		},
	},

	sources = {

		default = { "lsp", "snippets", "path", "dictionary", "buffer" },

		providers = {

			lsp = { score_offset = 100 },

			snippets = { score_offset = 90 },

			path = { score_offset = 30 },

			buffer = {
				score_offset = 10,
				min_keyword_length = 2,
				max_items = 4,
			},

			dictionary = {

				score_offset = 20,

				module = "blink-cmp-dictionary",
				name = "Dict",
				-- 💡 Performance impact of min_keyword_length:
				-- - In fallback mode: No impact on performance regardless of value
				-- - With fzf: Higher values may improve performance
				-- - With other commands (rg/grep): Higher values significantly improve performance
				min_keyword_length = 2,
				max_items = 6,
				-- options for blink-cmp-dictionary
				opts = {
					-- put your dictionary files here
					dictionary_directories = {
						vim.fn.stdpath("config") .. "/dictionary",
					},
				},
			},
		},
	},
})
