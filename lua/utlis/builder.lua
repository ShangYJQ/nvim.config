---Run the build action defined in a plugin spec.
---
---If the plugin spec contains `data.build`, this function executes shell
---commands in the plugin directory.
---
---@param spec table Plugin spec table from the PackChanged event.
---@param path string Plugin installation/update directory.
---@return nil
local function run_build(spec, path)
	local build = spec.data and spec.data.build
	if not build then
		return
	end

	local plugin_name = spec.name or spec.src or path

	if type(build) ~= "string" then
		vim.notify(("Unsupported build type for %s: %s"):format(plugin_name, type(build)), vim.log.levels.WARN)
		return
	end

	vim.notify(("[Building] %s..."):format(plugin_name), vim.log.levels.INFO)
	local result = vim.system({ "sh", "-c", build }, {
		cwd = path,
		text = true,
	}):wait()

	if result.code ~= 0 then
		local stderr = result.stderr or ""
		local stdout = result.stdout or ""
		local output = stderr ~= "" and stderr or stdout
		vim.notify(("Build failed for %s:\n%s"):format(plugin_name, output), vim.log.levels.ERROR)
		return
	end

	vim.notify(("[Built] %s"):format(plugin_name), vim.log.levels.INFO)
end

---Create an autocmd that runs a plugin build command after install or update.
---
---Triggered by Neovim's `PackChanged` event. When a package is installed or
---updated, it reads the plugin spec and runs its configured build command.
vim.api.nvim_create_autocmd("PackChanged", {
	---@param ev table PackChanged event data.
	callback = function(ev)
		if ev.data.kind == "install" or ev.data.kind == "update" then
			run_build(ev.data.spec, ev.data.path)
		end
	end,
})
