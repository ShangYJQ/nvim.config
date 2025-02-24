local opt = vim.opt

vim.cmd [[colorscheme tokyonight-moon]]

opt.number = true

opt.relativenumber = true

opt.whichwrap = "<,>,[,],h,l"
opt.splitbelow = true -- open new vertical split bottom
opt.splitright = true -- open new horizontal splits right

opt.mouse = 'a'

opt.tabstop = 4
opt.softtabstop = 4
opt.shiftwidth = 4
opt.expandtab = true
opt.autoindent = true

opt.iskeyword:append("-")

opt.showmode = false
opt.cursorline = true

opt.wrap = false

-- 设置撤销文件的保存路径
local undodir = vim.fn.stdpath("data") .. "/undodir"
if vim.fn.isdirectory(undodir) == 0 then
  -- 如果不存在就创建这个文件夹
  vim.fn.mkdir(undodir, "p")
end
opt.undodir = undodir
-- 启用持久化撤销
opt.undofile = true

opt.shadafile = "NONE"
