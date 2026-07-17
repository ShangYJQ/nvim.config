-- Blink.cmp(autocompletion)

local cmp = require("blink.cmp")

cmp.build():pwait(60000)

-- ---@param ctx blink.cmp.Context
-- ---@param items blink.cmp.CompletionItem[]
-- ---@return blink.cmp.CompletionItem[]
-- local function prefix_only_items(ctx, items)
-- 	local keyword = ctx:get_keyword():lower()
--
-- 	if keyword == "" then
-- 		return {}
-- 	end
--
-- 	return vim.tbl_filter(function(item)
-- 		local text = (item.filterText or item.label or ""):lower()
-- 		return vim.startswith(text, keyword)
-- 	end, items)
-- end
--
-- ---@param source blink.cmp.Source
-- ---@param ctx blink.cmp.Context
-- ---@param callback fun(response?: blink.cmp.CompletionResponse)
-- local function get_prefix_only_completions(source, ctx, callback)
-- 	return source:get_completions(ctx, function(response)
-- 		response = response or { items = {} }
-- 		response.items = prefix_only_items(ctx, response.items or {})
--
-- 		response.is_incomplete_forward = true
-- 		response.is_incomplete_backward = true
--
-- 		callback(response)
-- 	end)
-- end

-- vim.api.nvim_create_autocmd("FileType", {
-- 	pattern = { "c", "cpp", "objc", "objcpp", "cuda" },
-- 	callback = function()
-- 		-- clangd returns an empty complete result when "<" triggers completion in templates.
-- 		-- Block that trigger so typing the template argument asks clangd again.
-- 		vim.b.blink_cmp = vim.tbl_deep_extend("force", vim.b.blink_cmp or {}, {
-- 			completion = {
-- 				trigger = {
-- 					show_on_blocked_trigger_characters = { " ", "\n", "\t", "<" },
-- 				},
-- 			},
-- 		})
-- 	end,
-- })

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
		if bt ~= "" and ft ~= "sql" then
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
		["<Up>"] = {},
		["<Down>"] = {},
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
		menu = {
			border = nil,
			auto_show = true,
		},
	},

	cmdline = {
		enabled = true,
		completion = { menu = { auto_show = false } },
		sources = {
			default = { "cmdline" },
		},
		keymap = {
			-- ["<Tab>"] = {},
			-- ["<S-Tab>"] = {},

			["<C-l>"] = { "accept", "fallback" },
			["<CR>"] = { "accept_and_enter", "fallback" },

			["<C-k>"] = { "select_prev", "fallback" },
			["<C-j>"] = { "select_next", "fallback" },
		},
	},

	term = {
		enabled = false,
	},

	sources = {

		default = { "lsp", "dadbod_grip", "snippets", "path", "buffer" },

		providers = {

			lsp = { score_offset = 100 },

			snippets = {
				score_offset = 80,
				-- override = {
				-- 	get_completions = get_prefix_only_completions,
				-- },
			},

			path = { score_offset = 30 },

			buffer = {
				score_offset = 20,
				min_keyword_length = 2,
				max_items = 4,
			},

			dadbod_grip = {
				score_offset = 80,
				name = "Grip SQL",
				module = "dadbod-grip.completion.blink",
			},
		},
	},

	-- Experimental signature help support
	signature = { enabled = true },
})
