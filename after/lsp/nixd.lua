---@type vim.lsp.Config
return {
	cmd = { "nixd" },
	filetypes = { "nix" },
	root_markers = { "flake.nix", ".git" },
	settings = {
		nixd = {
			nixpkgs = {
				expr = "(builtins.getFlake (toString ./.)).inputs.nixpkgs.legacyPackages.${builtins.currentSystem}",
			},
			options = {
				nixos = {
					expr = '(builtins.getFlake (toString ./.)).nixosConfigurations."nixos".options',
				},
				home_manager = {
					expr = 'let flake = builtins.getFlake (toString ./.); in flake.nixosConfigurations."nixos".options.home-manager.users.type.getSubOptions []',
				},
			},
		},
	},
}
