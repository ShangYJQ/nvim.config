-- some settings only for neovide

vim.g.neovide_theme = "auto"
vim.g.neovide_refresh_rate = 165
vim.g.neovide_refresh_rate_idle = 30
-- vim.g.neovide_fullscreen = true
vim.g.neovide_cursor_antialiasing = true
vim.g.neovide_cursor_animation_length = 0.200
vim.g.neovide_cursor_short_animation_length = 0.08
vim.g.neovide_cursor_trail_size = 0.9
vim.g.neovide_cursor_hack = true
vim.g.neovide_cursor_smooth_blink = true

vim.o.guifont = "CaskaydiaCove Nerd Font:h14:n"
vim.g.neovide_scale_factor = 1.0
vim.g.neovide_text_gamma = 0.0
vim.g.neovide_text_contrast = 0.5

vim.g.neovide_padding_top = 0
vim.g.neovide_padding_bottom = 0
vim.g.neovide_padding_right = 0
vim.g.neovide_padding_left = 0

vim.g.neovide_floating_blur_amount_x = 2.0
vim.g.neovide_floating_blur_amount_y = 2.0

vim.g.neovide_floating_shadow = true
vim.g.neovide_floating_z_height = 10
vim.g.neovide_light_angle_degrees = 45
vim.g.neovide_light_radius = 5

vim.g.neovide_floating_corner_radius = 0.1

vim.g.neovide_opacity = 1
vim.g.neovide_normal_opacity = 1

vim.g.neovide_position_animation_length = 0.8

vim.g.neovide_hide_mouse_when_typing = true

vim.g.neovide_confirm_quit = true

-- improve inuput experience
local function set_ime(args)
	if args.event:match("Enter$") then
		vim.g.neovide_input_ime = true
	else
		vim.g.neovide_input_ime = false
	end
end

local ime_input = vim.api.nvim_create_augroup("ime_input", { clear = true })

vim.api.nvim_create_autocmd({ "InsertEnter", "InsertLeave" }, {
	group = ime_input,
	pattern = "*",
	callback = set_ime,
})

vim.api.nvim_create_autocmd({ "CmdlineEnter", "CmdlineLeave" }, {
	group = ime_input,
	pattern = "[/\\?]",
	callback = set_ime,
})
