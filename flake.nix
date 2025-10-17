{
  description = "NixOS Flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.05";
    home-manager = {
      url = "github:nix-community/home-manager/release-25.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    systems.url = "github:nix-systems/x86_64-linux";
    copai = {
      url = "github:inet4/copai";
      inputs.nixpkgs.follows = "nixpkgs"; # optional to prevent duplicates
      inputs.firefox-extensions.follows = "firefox-extensions"; # optional to prevent duplicates
    };

    firefox-extensions = {
      url = "gitlab:rycee/nur-expressions?dir=pkgs/firefox-addons";
      inputs.nixpkgs.follows = "nixpkgs";
    };

  };

  outputs =
    inputs@{
      self,
      nixpkgs,
      home-manager,
      firefox-extensions,
      copai,
      ...
    }:
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

              extraSpecialArgs = {
                extensions = firefox-extensions.packages.x86_64-linux;
              };

              users.max =
                { ... }:
                {
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
