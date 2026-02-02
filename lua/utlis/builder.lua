local M = {}

local build_configs = {
	["blink.cmp"] = {
		cmd = "cargo +nightly-2025-09-30 build --release",
		check_file = "target/release/libblink_cmp_fuzzy.so",
	},
	["blink.pairs"] = {
		cmd = "cargo +nightly-2025-09-30 build --release",
		check_file = "target/release/libblink_pairs.so",
	},
	["telescope-fzf-native.nvim"] = {
		cmd = "make",
		check_file = "build/libfzf.so",
	},
}

function M.setup_autobuild()
	local pack_path = vim.fn.stdpath("data") .. "/site/pack/core/opt/"

	for name, config in pairs(build_configs) do
		local plugin_path = pack_path .. name
		local check_path = plugin_path .. "/" .. config.check_file

		if vim.fn.isdirectory(plugin_path) == 1 and vim.fn.filereadable(check_path) == 0 then
			vim.notify("[building]: " .. name)

			local full_cmd = string.format("cd %s && %s", vim.fn.shellescape(plugin_path), config.cmd)
			local output = vim.fn.system(full_cmd)

			if vim.v.shell_error == 0 then
				vim.notify("[seccess]: " .. name .. " building successfully！")
			else
				vim.notify("[error] " .. name .. " building fail！\n" .. output)
				return false
			end
		end
	end
	-- vim.cmd("redraw")
	return true
end

return M
