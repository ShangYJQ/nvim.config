local ok, notify = pcall(require, "notify")
if ok then
	notify.setup({
		stages = "fade_in_slide_out",
		render = "compact",
		timeout = 2000,
		top_down = true,
		background_colour = "Normal",
	})

	-- 让所有插件的通知都走 notify
	vim.notify = notify
end
