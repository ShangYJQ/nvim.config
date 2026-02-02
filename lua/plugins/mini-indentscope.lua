-- mini indent
require("mini.indentscope").setup({
	symbol = "│",
	draw = {
		delay = 20,
		animation = require("mini.indentscope").gen_animation.cubic(),
		priority = 2,
	},
})
