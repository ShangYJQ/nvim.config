local dap = require("dap")
local dapui = require("dapui")

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
			return vim.fn.input("Path to executable: ", cwd .. "/.output/" .. filename, "file")
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
		-- runInTerminal = false,
	},
}

-- also for c
dap.configurations.c = dap.configurations.cpp

-- for dap ui to auto open
dap.listeners.before.attach.dapui_config = function()
	dapui.open()
end
dap.listeners.before.launch.dapui_config = function()
	dapui.open()
end
dap.listeners.before.event_terminated.dapui_config = function()
	dapui.close()
end
dap.listeners.before.event_exited.dapui_config = function()
	dapui.close()
end

-- keymaps
local map = vim.keymap.set

map("n", "<F5>", function()
	dap.continue()
end)

map("n", "<leader>dn", function()
	dap.step_over()
end, { desc = "DAP Step Over" })

map("n", "<leader>di", function()
	dap.step_into()
end, { desc = "DAP Step Into" })

map("n", "<leader>do", function()
	dap.step_out()
end, { desc = "DAP Step Out" })

map("n", "<Leader>b", function()
	dap.toggle_breakpoint()
end)

map("n", "<Leader>dq", function()
	dap.terminate()
end, { desc = "DAP Quit" })
