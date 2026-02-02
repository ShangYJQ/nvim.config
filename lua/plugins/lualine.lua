-- Lualine

local mode_map = {
	["NORMAL"] = "󰊠 普通",
	["INSERT"] = "󰏫 插入",
	["VISUAL"] = "󰈈 可视",
	["V-LINE"] = "󰈈 行视",
	["V-BLOCK"] = "󰈈 块视",
	["SELECT"] = "󰒅 选择",
	["S-LINE"] = "󰒅 行选",
	["S-BLOCK"] = "󰒅 块选",
	["REPLACE"] = "󰛔 替换",
	["V-REPLACE"] = "󰛔 虚替",
	["COMMAND"] = "󰘳 命令",
	["EX"] = "󰘳 执行",
	["TERMINAL"] = "󰞷 终端",
	["NONE"] = "󰀦 无",
}

require("lualine").setup({
	options = {
		icons_enabled = true,
		theme = "auto",
		-- component_separators = { left = "", right = "" },
		component_separators = " ",
		section_separators = { left = "", right = "" },
		-- section_separators = { left = "", right = "" },
		disabled_filetypes = {
			statusline = {},
			winbar = {},
		},
		ignore_focus = {},
		always_divide_middle = true,
		always_show_tabline = true,
		globalstatus = true,
		refresh = {
			statusline = 100,
			tabline = 100,
			winbar = 100,
		},
	},
	sections = {
		lualine_a = {
			{
				"mode",
				fmt = function(str)
					return mode_map[str] or str
				end,
				separator = { left = "", right = "" },
				padding = { left = 1, right = 2 },
			},
		},
		-- lualine_a = { { "mode", separator = { left = "", right = "" }, right_padding = 2 } },
		lualine_b = { "branch", "diff" },
		lualine_c = {
			{
				"diagnostics",
				symbols = {
					error = " ",
					warn = " ",
					info = " ",
					hint = " ",
				},
			},
			{ "filetype", icon_only = true, separator = "", padding = { left = 1, right = 0 } },
			"filename",
		},
		lualine_x = {
			{
				function()
					local clients = vim.lsp.get_clients({ bufnr = 0 })
					if #clients == 0 then
						return ""
					end
					local names = {}
					for _, c in ipairs(clients) do
						table.insert(names, c.name)
					end
					return " " .. table.concat(names, ", ")
				end,
			},
			"encoding",
			"fileformat",
		},
		lualine_y = {
			"progress",
		},
		lualine_z = {
			{
				function()
					return " " .. os.date("%R")
				end,
				separator = { left = "", right = "" },
			},
		},
	},
})
