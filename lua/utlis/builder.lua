---Run the build action defined in a plugin spec.
---
---If the plugin spec contains `data.build`, this function executes shell
---commands in the plugin directory, or calls Lua build functions with context.
---
---@param spec table Plugin spec table from the PackChanged event.
---@param path string Plugin installation/update directory.
---@return nil
local function run_build(spec, path)
	local build = spec.data and spec.data.build
	if not build then
		return
	end

	if type(build) == "string" then
		vim.system({ "sh", "-c", build }, {
			cwd = path,
			text = true,
		})
		return
	end

	if type(build) == "function" then
		local ok, err = pcall(build, {
			spec = spec,
			path = path,
			cwd = path,
		})
		if not ok then
			vim.notify(("Build failed for %s: %s"):format(spec.name or spec.src or path, err), vim.log.levels.ERROR)
		end
		return
	end

	vim.notify(
		("Unsupported build type for %s: %s"):format(spec.name or spec.src or path, type(build)),
		vim.log.levels.WARN
	)
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
