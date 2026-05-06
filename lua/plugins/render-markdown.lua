require("render-markdown").setup({
	latex = {
		-- Turn on / off latex rendering.
		enabled = true,
		-- Additional modes to render latex.
		render_modes = false,
		-- Executable used to convert latex formula to rendered unicode.
		-- If a list is provided the commands run in order until the first success.
		-- NOTE: brew install utftex
		converter = { "utftex" },
		-- Highlight for latex blocks.
		highlight = "RenderMarkdownMath",
		-- Determines where latex formula is rendered relative to block.
		-- | above  | above latex block                               |
		-- | below  | below latex block                               |
		-- | center | centered with latex block (must be single line) |
		position = "center",
		-- Number of empty lines above latex blocks.
		top_pad = 0,
		-- Number of empty lines below latex blocks.
		bottom_pad = 0,
	},

	completions = {
		-- Settings for blink.cmp completions source
		blink = { enabled = true },
		-- Settings for coq_nvim completions source
		coq = { enabled = false },
		-- Settings for in-process language server completions
		lsp = { enabled = true },
	},
})
