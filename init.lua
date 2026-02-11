vim.loader.enable()

-- 这个是配置的入口文件
require("config")
require("plugins")
require("utlis")

-- 默认主题
vim.cmd.colorscheme("kanagawa")
