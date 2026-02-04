-- add some commamd
vim.api.nvim_create_user_command("RebuildAllPlugins", function()
	require("utlis.builder").force_rebuild_all()
end, {
	desc = "Force rebuild all native plugins",
})
