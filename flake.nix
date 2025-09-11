{
	description = "NixOS Flake";
	
	inputs = {
		nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.05";
		home-manager = {
			url = "github:nix-community/home-manager/release-25.05";
			inputs.nixpkgs.follows = "nixpkgs";
		};
		helix.url = "github:helix-editor/helix/master";
		
		systems.url = "github:nix-systems/x86_64-linux";
	};

	outputs = inputs@{
		self, 
		nixpkgs,
	    home-manager, 
	    ...}:
	    {
		nixosConfigurations.nixos-max = nixpkgs.lib.nixosSystem {
			system = "x86_64-linux";

			specialArgs = { inherit inputs; };
			
			modules = [
				./configuration.nix
				./modules/packettracer.nix
				home-manager.nixosModules.home-manager
				{
					home-manager = {
						useGlobalPkgs = true;
						useUserPackages = true;
							
						backupFileExtension = "backup";

						users.max = {...}:{
							imports = [
								./home/default.nix	
							];	
						};
					};
				}
			];
		};
	};
}
