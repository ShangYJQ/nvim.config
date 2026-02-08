-- KEYMAPS

local map = vim.keymap.set

-- General editing
map("i", "<C-q>", "<Esc>", { desc = "Exit insert mode" })
map("n", "<C-q>", "<cmd>q<CR>", { desc = "Quit" })
map("n", "<C-Q>", "<cmd>q!<CR>", { desc = "Forced quit" })
-- map("n", "<C-z>", "<cmd>undo<CR>", { desc = "Undo" })
map({ "n", "v" }, "d", '"_d', { desc = "Delete to black hole register" })
map("n", "<leader>c", "<cmd>nohlsearch<CR>", { desc = "Clear search highlight" })

-- Window navigation (Ctrl + hjkl)
map("n", "<C-h>", "<C-w>h", { desc = "Focus left window" })
map("n", "<C-j>", "<C-w>j", { desc = "Focus below window" })
map("n", "<C-k>", "<C-w>k", { desc = "Focus above window" })
map("n", "<C-l>", "<C-w>l", { desc = "Focus right window" })

-- Window splitting (leader + hjkl)
map("n", "<leader>l", "<cmd>set splitright<CR><cmd>vsplit<CR>", { desc = "Split right" })
map("n", "<leader>j", "<cmd>set splitbelow<CR><cmd>split<CR>", { desc = "Split below" })
map("n", "<leader>h", "<cmd>set nosplitright<CR><cmd>vsplit<CR><cmd>set splitright<CR>", { desc = "Split left" })
map("n", "<leader>k", "<cmd>set nosplitbelow<CR><cmd>split<CR><cmd>set splitbelow<CR>", { desc = "Split above" })

-- Window resizing (Ctrl + arrows)
map("n", "<C-Up>", "<cmd>resize -2<CR>", { desc = "Decrease height" })
map("n", "<C-Down>", "<cmd>resize +2<CR>", { desc = "Increase height" })
map("n", "<C-Left>", "<cmd>vertical resize -2<CR>", { desc = "Decrease width" })
map("n", "<C-Right>", "<cmd>vertical resize +2<CR>", { desc = "Increase width" })

-- Tab navigation
map("n", "<S-n>", ":tabnew ", { desc = "New tab" })

-- Terminal
-- map("n", "<leader>t", function()
-- 	vim.cmd("botright 10split | terminal")
-- 	vim.cmd("startinsert")
-- end, { desc = "Open terminal" })
map("t", "<C-q>", [[<C-\><C-n>]], { desc = "Exit terminal mode" })

-- helix move
map("n", "gs", "0", { desc = "Move to left" })
map("n", "gl", "$", { desc = "Move to right" })

-- move code
map("n", "<A-k>", ":move .-2<CR>==", { noremap = true, silent = true })
map("n", "<A-j>", ":move .+1<CR>==", { noremap = true, silent = true })

-- change x to helix mode
map("n", "x", "V", { noremap = true, silent = true })
map("v", "x", "<Esc>", { noremap = true, silent = true })

-- Toggle cmdheight
map("n", "<leader>z", function()
	if vim.o.cmdheight == 0 then
		vim.o.cmdheight = 1
	else
		vim.o.cmdheight = 0
	end
end, { silent = true, desc = "Toggle cmdheight" })

-- auto close pairs
-- map("i", "'", "''<left>")
-- map("i", "`", "``<left>")
-- map("i", '"', '""<left>')
-- map("i", "(", "()<left>")
-- map("i", "[", "[]<left>")
-- map("i", "{", "{}<left>")
-- map("i", "<", "<><left>")

-- LSP CONFIGURATION

-- LSP keymaps
vim.api.nvim_create_autocmd("LspAttach", {
	group = vim.api.nvim_create_augroup("lsp-attach", { clear = true }),
	callback = function(event)
		local buf = event.buf
		local client = vim.lsp.get_client_by_id(event.data.client_id)

		-- add omnifunc to cmp with lsp
		vim.bo[buf].omnifunc = "v:lua.vim.lsp.omnifunc"

		-- Toggle inlay hints if supported
		if client and client:supports_method(vim.lsp.protocol.Methods.textDocument_inlayHint) then
			map("n", "<leader>ih", function()
				vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = buf }))
			end, { buffer = buf, desc = "LSP: Toggle inlay hints" })
		end

		-- Navigation
		map("n", "gd", vim.lsp.buf.definition, { buffer = buf, desc = "LSP: Go to definition" })
		map("n", "gD", vim.lsp.buf.declaration, { buffer = buf, desc = "LSP: Go to declaration" })
		map("n", "gi", vim.lsp.buf.implementation, { buffer = buf, desc = "LSP: Go to implementation" })
		map("n", "gr", vim.lsp.buf.references, { buffer = buf, desc = "LSP: Find references" })
		map("n", "gy", vim.lsp.buf.type_definition, { buffer = buf, desc = "LSP: Go to type definition" })

		-- Documentation and help
		map("n", "K", vim.lsp.buf.hover, { buffer = buf, desc = "LSP: Hover documentation" })
		map("i", "<C-k>", vim.lsp.buf.signature_help, { buffer = buf, desc = "LSP: Signature help" })

		-- Code actions
		map("n", "<leader>a", vim.lsp.buf.code_action, { buffer = buf, desc = "LSP: Code action" })
		map("n", "<leader>r", vim.lsp.buf.rename, { buffer = buf, desc = "LSP: Rename symbol" })

		-- Diagnostics
		-- map("n", "<leader>e", vim.diagnostic.open_float, { buffer = buf, desc = "LSP: Show diagnostics" })
		map("n", "<leader>D", function()
			vim.diagnostic.open_float({ source = true })
		end, { buffer = buf, desc = "LSP: Show diagnostics with source" })

		-- 快速复制lsp信息

		-- <leader>y: 仅复制当前光标下的第一条报错
		map("n", "<leader>y", function()
			local diagnostics = vim.diagnostic.get(0, { lnum = vim.api.nvim_win_get_cursor(0)[1] - 1 })
			if #diagnostics > 0 then
				vim.fn.setreg("+", diagnostics[1].message)
				vim.notify("Copied current diagnostic!")
			else
				vim.notify("No diagnostic at cursor")
			end
		end, { buffer = buf, desc = "LSP: Copy current diagnostic" })

		-- <leader>Y: 复制当前文件所有的报错信息
		map("n", "<leader>Y", function()
			local diagnostics = vim.diagnostic.get(0)
			if #diagnostics > 0 then
				local messages = ""
				for i, d in ipairs(diagnostics) do
					messages = messages .. string.format("[%d] Line %d: %s\n", i, d.lnum + 1, d.message)
				end
				vim.fn.setreg("+", messages)
				vim.notify("Copied all " .. #diagnostics .. " diagnostics!")
			else
				vim.notify("No diagnostics in current buffer")
			end
		end, { buffer = buf, desc = "LSP: Copy all diagnostics" })

		-- Override diagnostic float with tiny-inline-diagnostic
		vim.diagnostic.open_float = require("tiny-inline-diagnostic.override").open_float
	end,
})
