-- auto create dir
vim.api.nvim_create_autocmd({ "BufWritePre" }, {
	pattern = "*",
	callback = function(event)
		if event.match:match("^%w%w+:[\\/][\\/]") then
			return
		end
		local file = vim.uv.fs_realpath(event.match) or event.match
		vim.fn.mkdir(vim.fn.fnamemodify(file, ":p:h"), "p")
	end,
})

-- Highlight when yanking
vim.api.nvim_create_autocmd("TextYankPost", {
	desc = "Highlight when yanking (copying) text",
	group = vim.api.nvim_create_augroup("highlight-yank", { clear = true }),
	callback = function()
		vim.highlight.on_yank()
	end,
})

-- Restore cursor to file position in previous editing session
vim.api.nvim_create_autocmd("BufReadPost", {
	callback = function(args)
		local mark = vim.api.nvim_buf_get_mark(args.buf, '"')
		local line_count = vim.api.nvim_buf_line_count(args.buf)
		if mark[1] > 0 and mark[1] <= line_count then
			vim.cmd('normal! g`"zz')
		end
	end,
})

-- Disable format options
vim.api.nvim_create_autocmd("FileType", {
	pattern = "*",
	callback = function()
		vim.opt_local.formatoptions:remove({ "c", "r", "o" })
	end,
})

-- close some filetypes with <q>
vim.api.nvim_create_autocmd("FileType", {
	pattern = {
		"help",
		"gitsigns-blame",
	},
	callback = function(event)
		vim.bo[event.buf].buflisted = false
		vim.keymap.set("n", "q", "<cmd>close<cr>", { buffer = event.buf, silent = true })
	end,
})

-- force filetype detect
-- vim.api.nvim_create_autocmd({ "BufEnter", "BufWinEnter" }, {
-- 	callback = function(args)
-- 		local b = args.buf
-- 		if vim.bo[b].buftype == "" and vim.api.nvim_buf_get_name(b) ~= "" and vim.bo[b].filetype == "" then
-- 			vim.cmd("silent! filetype detect")
-- 		end
-- 	end,
-- })

-- Boot time
-- local uv = vim.uv
-- local start_ns = uv.hrtime()
--
-- vim.api.nvim_create_autocmd("VimEnter", {
-- 	callback = function()
-- 		vim.schedule(function()
-- 			local elapsed_ms = (uv.hrtime() - start_ns) / 1e6
-- 			vim.notify(("⚡ Neovim loaded in %.2f ms"):format(elapsed_ms), vim.log.levels.INFO, {
-- 				title = "Startup",
-- 				timeout = 0,
-- 			})
-- 		end)
-- 	end,
-- })

local function dashboard()
	if vim.fn.argc() == 0 and vim.fn.line("$") == 1 and vim.fn.getline(1) == "" then
		local logo_raw = [[
███████╗██╗  ██╗ █████╗ ███╗   ██╗ ██████╗
██╔════╝██║  ██║██╔══██╗████╗  ██║██╔════╝
███████╗███████║███████║██╔██╗ ██║██║   ███╗
╚════██║██╔══██║██╔══██║██║╚██╗██║██║   ██║
███████║██║  ██║██║  ██║██║ ╚████║╚██████╔╝
╚══════╝╚═╝  ╚═╝╚═╝  ╚═╝╚═╝  ╚═══╝ ╚═════╝

                  ██╗   ██╗   ██╗ ██████╗
                  ╚██╗ ██╔╝   ██║██╔═══██╗
                   ╚████╔╝    ██║██║   ██║
                    ╚██╔╝██   ██║██║▄▄ ██║
                     ██║ ╚█████╔╝╚██████╔╝
                     ╚═╝  ╚════╝  ╚══▀▀═╝]]

		local lines = {}
		for s in logo_raw:gmatch("[^\r\n]+") do
			table.insert(lines, s)
		end

		local win_width = vim.api.nvim_win_get_width(0)
		local win_height = vim.api.nvim_win_get_height(0)

		local max_width = 0
		for _, line in ipairs(lines) do
			local width = vim.fn.strdisplaywidth(line)
			if width > max_width then
				max_width = width
			end
		end

		local padding = math.floor((win_width - max_width) / 2)
		if padding < 0 then
			padding = 0
		end
		local pad_str = string.rep(" ", padding)

		local centered_logo = {}
		local top_padding = math.max(0, math.floor((win_height - #lines) / 3))
		for _ = 1, top_padding do
			table.insert(centered_logo, "")
		end

		for _, line in ipairs(lines) do
			table.insert(centered_logo, pad_str .. line)
		end

		vim.api.nvim_buf_set_lines(0, 0, -1, false, centered_logo)

		vim.opt_local.list = false
		vim.opt_local.number = false
		vim.opt_local.relativenumber = false
		vim.opt_local.cursorline = false
		vim.opt_local.buftype = "nofile"
		vim.opt_local.bufhidden = "wipe"
		vim.opt_local.modifiable = false
	end
end

vim.api.nvim_create_autocmd("VimEnter", { callback = dashboard })
