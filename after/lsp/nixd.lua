---@type vim.lsp.Config
return {
	cmd = { "nixd" },
	filetypes = { "nix" },
	root_markers = { "flake.nix", ".git" },
	settings = {
		nixd = {
			nixpkgs = {
				expr = 'import (builtins.getFlake "/home/yjq/nixos").inputs.nixpkgs { system = "x86_64-linux"; config.allowUnfree = true; }',
			},
			options = {
				nixos = {
					expr = '(builtins.getFlake "/home/yjq/nixos").nixosConfigurations."nixos".options',
				},
				home_manager = {
					expr = '(builtins.getFlake "/home/yjq/nixos").nixosConfigurations."nixos".options.home-manager.users.type.getSubOptions []',
				},
			},
		},
	},
}
