local ui2 = require("vim._core.ui2")
local msgs = require("vim._core.ui2.messages")
local orig_set_pos = msgs.set_pos

-- 消息在 msg 窗口停留 3 秒；pager 用 g< 打开
vim.opt.messagesopt:append("timeout:3000")

-- msg 窗口固定在右上角；set_pos(tgt, focus) 的其余参数要透传，否则 :messages 进不了 pager
msgs.set_pos = function(tgt, ...)
	orig_set_pos(tgt, ...)
	if (tgt == "msg" or tgt == nil) and vim.api.nvim_win_is_valid(ui2.wins.msg) then
		pcall(vim.api.nvim_win_set_config, ui2.wins.msg, {
			relative = "editor",
			anchor = "NE",
			row = 0,
			col = vim.o.columns - 1,
			border = "rounded",
		})
	end
end

ui2.enable({
	enable = true, -- Whether to enable or disable the UI.
	msg = {
		-- 路由优先级：trigger > key 作为 Lua pattern 匹配字符串 message id > kind > default
		targets = {
			default = "msg",

			-- 内置 progress 消息的 id
			["nvim.bufwrite"] = "msg",
			["nvim.completion"] = "cmd",
			["nvim.indent"] = "msg",

			-- kind
			empty = "cmd",
			confirm = "cmd",
			emsg = "pager",
			echo = "msg",
			echomsg = "msg",
			echoerr = "pager",
			completion = "cmd",
			list_cmd = "pager",
			lua_error = "pager",
			lua_print = "msg",
			progress = "pager",
			rpc_error = "pager",
			quickfix = "msg",
			search_cmd = "cmd",
			search_count = "cmd",
			shell_cmd = "pager",
			shell_err = "pager",
			shell_out = "pager",
			shell_ret = "msg",
			undo = "msg",
			verbose = "pager",
			wildlist = "cmd",
			wmsg = "msg",

			-- trigger
			typed_cmd = "msg",
		},
		dialog = {
			height = 0.5,
		},
		msg = {
			height = 0.3,
		},
		pager = {
			height = 0.5,
		},
	},
})
