-- Blink.cmp(autocompletion)
require("blink.cmp").setup({
	enabled = function()
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
		["<C-space>"] = { "show", "show_documentation", "hide_documentation" },
		["<CR>"] = { "accept", "fallback" },
		["<C-Down>"] = { "scroll_documentation_down", "fallback" },
		["<C-Up>"] = { "scroll_documentation_up", "fallback" },
		["<Tab>"] = { "snippet_forward", "fallback" },
		["<S-Tab>"] = { "snippet_backward", "fallback" },
		["<Up>"] = { "select_prev", "fallback" },
		["<Down>"] = { "select_next", "fallback" },
		["<C-n>"] = { "select_next", "fallback" },
		["<C-p>"] = { "select_prev", "fallback" },
		["<C-e>"] = { "hide", "fallback" },
	},
	fuzzy = { implementation = "prefer_rust_with_warning" },
	completion = {
		documentation = {
			auto_show = false,
			auto_show_delay_ms = 500,
		},
		ghost_text = { enabled = true },
	},
})
