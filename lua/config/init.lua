require("config.autocmd")
require("config.globals")
require("config.lsp")
require("config.options")
require("config.keymap")

-- neovide config
if vim.g.neovide then
	-- vim.notify("Config for neovide")
	require("config.neovide")
end
