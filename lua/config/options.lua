-- EDITOR OPTIONS
local opt = vim.opt

-- 隐藏命令行
opt.cmdheight = 0
opt.laststatus = 3

opt.shortmess:append("I")
opt.shortmess:append("W")
opt.shortmess:append("F")
opt.shortmess:append("s")
opt.shortmess:append("A")

opt.more = false

--  退出对话框
opt.confirm = true

-- Display
opt.number = true
opt.relativenumber = true
opt.cursorline = true
opt.showmode = false
opt.winborder = "rounded"

-- Line wrapping and cursor movement
opt.whichwrap = "<,>,[,],h,l"
opt.wrap = false

-- listchars
opt.list = true
opt.listchars = {
	space = "·",
	tab = "→ ",
}

-- Indentation
local tablen = 4
opt.tabstop = tablen
opt.softtabstop = tablen
opt.shiftwidth = tablen
opt.expandtab = false
opt.autoindent = true
vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"

-- use conform
-- vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"

-- Clipboard
opt.clipboard = vim.env.SSH_TTY and "" or "unnamedplus"

-- Window splits
opt.splitright = true
opt.splitbelow = true

-- Scrolling
opt.scrolloff = 8
opt.sidescrolloff = 8
opt.smoothscroll = true

-- Persistent undo
local undodir = vim.fn.stdpath("data") .. "/undodir"
if vim.fn.isdirectory(undodir) == 0 then
	vim.fn.mkdir(undodir, "p")
end

opt.undodir = undodir
opt.undofile = true

-- Search
opt.ignorecase = true
opt.smartcase = true

-- Folding via Treesitter
-- opt.foldmethod = "expr"
-- opt.foldexpr = "v:lua.vim.treesitter.foldexpr()"
opt.foldlevel = 99

-- ufo setting
opt.foldcolumn = "1"
opt.foldlevelstart = 99
opt.foldenable = true
vim.o.fillchars = "eob: ,fold: ,foldopen: ,foldsep: ,foldinner: ,foldclose: "
