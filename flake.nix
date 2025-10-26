{
  description = "NixOS Flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.05";
    systems.url = "github:nix-systems/x86_64-linux";

    home-manager = {
      url = "github:nix-community/home-manager/release-25.05";
      inputs.nixpkgs.follows = "nixpkgs";
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
      ...
    }:
    let
      system = "x86_64-linux";
      pkgs = pkgsExternal; # Just use pkgsExternal directly—no overlay needed

      pkgsExternal = import nixpkgs {
        inherit system;
        config = {
          allowUnfree = true;
          permittedInsecurePackages = [
            "dotnet-sdk-6.0.428"
            "dotnet-runtime-6.0.36"
          ];
        };
      };

      unstablePkgs = import inputs.nixpkgs {
        inherit system;
        config.allowUnfree = true;
        config.permittedInsecurePackages = [
          "dotnet-sdk-6.0.428"
          "dotnet-runtime-6.0.36"
        ];
      };

      extra = {
        extensions = firefox-extensions.packages.${system};
      };
    in
    {
      nixosConfigurations.nixos-max = nixpkgs.lib.nixosSystem {
        inherit system pkgs;

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
                inherit unstablePkgs;
                extensions = extra.extensions;
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
