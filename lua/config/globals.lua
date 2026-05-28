-- nvchad base46_cache dir
vim.g.base46_cache = vim.fn.stdpath("data") .. "/base46_cache/"

-- control auto fmt
vim.g.autoformat_enabled = true

-- 主键
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- 禁用 netrw
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

vim.g.have_nerd_font = true

-- 禁用不需要的语言环境
vim.g.loaded_ruby_provider = 0
vim.g.loaded_perl_provider = 0
vim.g.loaded_node_provider = 0
vim.g.loaded_python3_provider = 0

vim.g.did_install_default_menus = 1

-- 不加载 tutor
vim.g.loaded_tutor_mode_plugin = 1

-- Do not use builtin matchit.vim and matchparen.vim since we use blink.pairs
vim.g.loaded_matchit = 1
vim.g.loaded_matchparen = 1

-- Disable sql omni completion, it is broken.
vim.g.loaded_sql_completion = 1

-- 解决 sql 文件不断报错打断
vim.g.omni_sql_no_default_maps = 1

-- Disable archive/compressed file plugins
vim.g.loaded_gzip = 1
vim.g.loaded_tar = 1
vim.g.loaded_tarPlugin = 1
vim.g.loaded_zip = 1
vim.g.loaded_zipPlugin = 1

-- Disable EditorConfig
vim.g.editorconfig = false

-- Disable spellfile downloader
vim.g.loaded_spellfile_plugin = 1
