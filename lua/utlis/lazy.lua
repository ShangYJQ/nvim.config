---@class UtilsLazy
local M = {}

---@type table<string, boolean>
local loaded = {}
local map = vim.keymap.set

---懒加载一个 Lua 模块，并缓存成功加载的状态。
---后续再次使用同一个 `name` 时不会重复加载，而是直接返回 `true`。
---@param name string 用于缓存和错误提示的标识名。
---@param module string 传给 `require` 的模块名。
---@return boolean ok 是否成功加载模块。
function M.require(name, module)
	if loaded[name] then
		return true
	end

	local ok, err = pcall(require, module)
	if not ok then
		vim.notify(("Failed to load %s: %s"):format(name, err), vim.log.levels.ERROR)
		return false
	else
		-- vim.notify(("Succeeded to load %s !"):format(name), vim.log.levels.INFO)
	end

	loaded[name] = true
	return true
end

---在懒加载完成后，重新触发原始按键序列。
---@param lhs string 映射左侧按键，例如 `<leader>x`。
local function replay(lhs)
	local keys = vim.api.nvim_replace_termcodes(lhs, true, false, true)
	vim.api.nvim_feedkeys(keys, "m", false)
end

---创建一个普通模式下的懒加载按键映射。
---第一次触发时先加载 `module`，然后重放原始按键，
---这样插件自己定义的真实映射就可以继续接管后续行为。
---@param lhs string 要映射的普通模式按键。
---@param name string 用于缓存懒加载状态的标识名。
---@param module string 第一次使用时需要 `require` 的模块名。
---@param opts? vim.keymap.set.Opts 传递给 `vim.keymap.set` 的可选参数。
function M.map(lhs, name, module, opts)
	map("n", lhs, function()
		if not M.require(name, module) then
			return
		end

		vim.schedule(function()
			replay(lhs)
		end)
	end, opts)
end

return M
