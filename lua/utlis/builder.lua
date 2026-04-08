---@class BuilderConfig
---@field cmd string 用于构建插件的命令。
---@field check_files string[] 用于判断构建产物是否存在的文件列表。

---@class UtilsBuilder
local M = {}

---@type table<string, BuilderConfig>
local build_configs = {
	["blink.cmp"] = {
		cmd = "cargo build --release",
		check_files = {
			"target/release/libblink_cmp_fuzzy.so",
			"target/release/libblink_cmp_fuzzy.dylib",
		},
	},
	["blink.pairs"] = {
		cmd = "cargo build --release",
		check_files = {
			"target/release/libblink_pairs.so",
			"target/release/libblink_pairs.dylib",
		},
	},
	["telescope-fzf-native.nvim"] = {
		cmd = "make",
		check_files = {
			"build/libfzf.so",
			"build/libfzf.dylib",
		},
	},
}

---执行单个插件的构建命令，并根据退出状态返回是否成功。
---@param plugin_path string 插件目录的绝对路径。
---@param name string 用于通知提示的插件名称。
---@param config BuilderConfig 当前插件对应的构建配置。
---@return boolean ok 构建是否成功。
local function build_successfully(plugin_path, name, config)
	vim.notify("[building]: " .. name)

	local full_cmd = string.format("cd %s && %s", vim.fn.shellescape(plugin_path), config.cmd)
	local output = vim.fn.system(full_cmd)

	if vim.v.shell_error == 0 then
		vim.notify("[success]: " .. name .. " building successfully！")
		return true
	end

	vim.notify("[error] " .. name .. " building fail！\n" .. output)
	return false
end

---检查插件目录中是否已经存在任意一个构建产物。
---@param plugin_path string 插件目录的绝对路径。
---@param config BuilderConfig 当前插件对应的构建配置。
---@return boolean has_artifact 是否检测到构建产物。
local function has_build_artifact(plugin_path, config)
	for _, check_file in ipairs(config.check_files or {}) do
		local check_path = plugin_path .. "/" .. check_file
		if vim.fn.filereadable(check_path) == 1 then
			return true
		end
	end

	return false
end

---按配置批量构建插件。
---@param force boolean 是否强制重建，即使构建产物已存在。
---@return boolean ok 所有插件是否都构建成功。
local function build_plugins(force)
	local pack_path = vim.fn.stdpath("data") .. "/site/pack/core/opt/"

	for name, config in pairs(build_configs) do
		local plugin_path = pack_path .. name

		if vim.fn.isdirectory(plugin_path) == 1 and (force or not has_build_artifact(plugin_path, config)) then
			if not build_successfully(plugin_path, name, config) then
				return false
			end
		end
	end

	return true
end

---自动构建缺失原生产物的插件。
---@return boolean ok 所有需要构建的插件是否都处理成功。
function M.setup_autobuild()
	return build_plugins(false)
end

---强制重建所有已配置的原生插件。
---@return boolean ok 所有插件是否都重建成功。
function M.force_rebuild_all()
	return build_plugins(true)
end

return M
