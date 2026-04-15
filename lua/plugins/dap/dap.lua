local dap = require("dap")

dap.adapters.lldb = {
	type = "executable",
	-- adjust as needed, must be absolute path
	command = "/opt/homebrew/opt/llvm/bin/lldb-dap", -- MacOS
	name = "lldb",
}

dap.configurations.cpp = {
	{
		name = "Launch",
		type = "lldb",
		request = "launch",
		program = function()
			local cwd = vim.fn.getcwd()
			local filename = vim.fn.expand("%:t:r")
			-- return vim.fn.input("Path to executable: ", cwd .. "/.output/" .. filename, "file")
			local path = cwd .. "/.output/" .. filename
			local file = io.open(path, "r")
			if file then
				file:close()
				return path
			else
				vim.notify("请先编译 : " .. path, vim.log.levels.ERROR)
				return nil
			end
		end,
		cwd = "${workspaceFolder}",
		stopOnEntry = false,
		args = {},

		-- 💀
		-- if you change `runInTerminal` to true, you might need to change the yama/ptrace_scope setting:
		--
		--    echo 0 | sudo tee /proc/sys/kernel/yama/ptrace_scope
		--
		-- Otherwise you might get the following error:
		--
		--    Error on launch: Failed to attach to the target process
		--
		-- But you should be aware of the implications:
		-- https://www.kernel.org/doc/html/latest/admin-guide/LSM/Yama.html
		runInTerminal = true,
	},
}

-- also for c
dap.configurations.c = dap.configurations.cpp

-- Install hdb
-- cabal install haskell-debugger \
--     --allow-newer=base,time,containers,ghc,ghc-bignum,template-haskell \
--     --enable-executable-dynamic

dap.adapters["haskell-debugger"] = {
	type = "server",
	port = "${port}",
	executable = {
		command = "hdb",
		args = {
			"server",
			"--port",
			"${port}",
		},
	},
}

dap.configurations.haskell = {
	{
		type = "haskell-debugger",
		request = "launch",
		name = "hdb:file:main",
		entryFile = "${file}",
		entryPoint = "main",
		projectRoot = "${workspaceFolder}",
		entryArgs = {},
		extraGhcArgs = {},
	},
}

vim.fn.sign_define("DapBreakpoint", {
	text = "󰧞",
	texthl = "DiagnosticSignError",
})

vim.fn.sign_define("DapBreakpointCondition", {
	text = "",
	texthl = "DiagnosticSignWarn",
})

vim.fn.sign_define("DapLogPoint", {
	text = "󰋼",
	texthl = "DiagnosticSignInfo",
})

vim.fn.sign_define("DapStopped", {
	text = "󰁕",
	texthl = "DiagnosticSignHint",
	linehl = "Visual",
})

-- keymaps
local map = vim.keymap.set

map("n", "<F5>", function()
	dap.continue()
end, { silent = true, desc = "DAP Continue" })

map("n", "<leader>dn", function()
	dap.step_over()
end, { silent = true, desc = "DAP Step Over" })

map("n", "<leader>di", function()
	dap.step_into()
end, { silent = true, desc = "DAP Step Into" })

map("n", "<leader>do", function()
	dap.step_out()
end, { silent = true, desc = "DAP Step Out" })

map("n", "<Leader>b", function()
	dap.toggle_breakpoint()
end, { silent = true, desc = "DAP Add Breakpoint" })

map("n", "<Leader>dq", function()
	dap.terminate()
end, { silent = true, desc = "DAP Quit" })

map("n", "<Leader>dv", function()
	require("dap-view").toggle()
end, { silent = true, desc = "DAP View toggle" })
