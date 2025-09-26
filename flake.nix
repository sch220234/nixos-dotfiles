{
  description = "NixOS Flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.05";
    home-manager = {
      url = "github:nix-community/home-manager/release-25.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    systems.url = "github:nix-systems/x86_64-linux";

    firefox-extensions = {
      url = "gitlab:rycee/nur-expressions?dir=pkgs/firefox-addons";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    winapps.url = "github:winapps-org/winapps";
  };

  outputs =
    inputs@{
      self,
      nixpkgs,
      home-manager,
      firefox-extensions,
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
                winapps = inputs.winapps;
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
