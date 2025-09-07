{
	description = "NixOS Flake";
	
	inputs = {
		nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.05";
		home-manager = {
			url = "github:nix-community/home-manager/release-25.05";
			inputs.nixpkgs.follows = "nixpkgs";
		};

		systems.url = "github:nix-systems/x86_64-linux";
	};

	outputs = {
		self, 
		nixpkgs,
	    home-manager, 
	    ...}:
	    {
		nixosConfigurations.nixos-max = nixpkgs.lib.nixosSystem {
			system = "x86_64-linux";
			modules = [
				./configuration.nix
				home-manager.nixosModules.home-manager
				{
					home-manager = {
						useGlobalPkgs = true;
						useUserPackages = true;
						
						users.max = import ./home.nix;	
						backupFileExtension = "backup";
					};
				}
			];
		};
	};
}
