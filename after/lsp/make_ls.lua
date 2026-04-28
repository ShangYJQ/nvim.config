---@type vim.lsp.Config
return {
	-- go install github.com/owenrumney/make-ls/cmd/make-ls@latest
	cmd = { "make-ls" },
	filetypes = { "make" },
	root_markers = { "Makefile", "makefile", "GNUmakefile", ".git" },
}
