local M = {}

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

local function has_build_artifact(plugin_path, config)
	for _, check_file in ipairs(config.check_files or {}) do
		local check_path = plugin_path .. "/" .. check_file
		if vim.fn.filereadable(check_path) == 1 then
			return true
		end
	end

	return false
end

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

function M.setup_autobuild()
	return build_plugins(false)
end

function M.force_rebuild_all()
	return build_plugins(true)
end

return M
