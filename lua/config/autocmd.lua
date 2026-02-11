-- auto create dir
vim.api.nvim_create_autocmd({ "BufNewFile", "BufWritePre" }, {
	pattern = "*",
	callback = function()
		local file_path = vim.fn.expand("<afile>:p:h")
		if file_path:match("^%w+://") then
			return
		end
		if vim.fn.isdirectory(file_path) == 0 then
			vim.fn.mkdir(file_path, "p")
		end
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

-- force filetype detect
vim.api.nvim_create_autocmd({ "BufEnter", "BufWinEnter" }, {
	callback = function(args)
		local b = args.buf
		if vim.bo[b].buftype == "" and vim.api.nvim_buf_get_name(b) ~= "" and vim.bo[b].filetype == "" then
			vim.cmd("silent! filetype detect")
		end
	end,
})

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
