-- Dart follows the official two-space indentation style.
vim.opt_local.tabstop = 2
vim.opt_local.softtabstop = 2
vim.opt_local.shiftwidth = 2
vim.opt_local.expandtab = true

vim.opt_local.cindent = true
-- 全局 indentexpr（treesitter）会覆盖 cindent，而 dart 的 treesitter 缩进不准，清空让 cindent 生效
vim.opt_local.indentexpr = ""
