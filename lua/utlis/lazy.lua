---@class UtilsLazy
local M = {}

local keymap = vim.keymap
local api = vim.api
local cmd = vim.cmd

local DEBUG = false

--- 重放按键序列（处理 <leader> 等特殊键）
---@param lhs string
local function replay(lhs)
	local keys = api.nvim_replace_termcodes(lhs, true, false, true)
	api.nvim_feedkeys(keys, "m", false)
end

--- 创建懒加载按键映射桩。
--- 首次触发时：删除桩 → 执行回调 → 重放按键。
---@param mode string|string[]
---@param lhs string
---@param callback function
---@param opts? vim.keymap.set.Opts
function M.keymap_stub(mode, lhs, callback, opts)
	keymap.set(mode, lhs, function()
		keymap.del(mode, lhs)
		if DEBUG then
			vim.notify(("[lazy] keymap_stub triggered: %s"):format(lhs), vim.log.levels.INFO)
		end
		callback()
		replay(lhs)
	end, opts)
end

--- 创建懒加载命令桩。
--- 首次触发时：删除桩 → 执行回调 → 重放命令（保留参数）。
---@param name string
---@param callback function
function M.command_stub(name, callback)
	api.nvim_create_user_command(name, function(info)
		api.nvim_del_user_command(name)
		if DEBUG then
			vim.notify(("[lazy] command_stub triggered: %s %s"):format(name, info.args), vim.log.levels.INFO)
		end
		callback()
		if info.args ~= "" then
			cmd(name .. " " .. info.args)
		else
			cmd(name)
		end
	end, { nargs = "*" })
end

--- 创建懒加载 require 桩。
--- 当模块被 require 时，清除桩并执行回调返回真正的模块。
---@param mod string
---@param callback function
function M.require_stub(mod, callback)
	package.preload[mod] = function()
		package.loaded[mod] = nil
		package.preload[mod] = nil
		if DEBUG then
			vim.notify(("[lazy] require_stub triggered: %s"):format(mod), vim.log.levels.INFO)
		end
		return callback()
	end
end

return M
