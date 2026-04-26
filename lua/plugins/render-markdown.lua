require("render-markdown").setup({
	latex = { enabled = false },
	completions = {
		-- Settings for blink.cmp completions source
		blink = { enabled = true },
		-- Settings for coq_nvim completions source
		coq = { enabled = false },
		-- Settings for in-process language server completions
		lsp = { enabled = true },
	},
})
