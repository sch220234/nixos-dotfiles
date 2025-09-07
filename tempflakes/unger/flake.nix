{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.05";
  };

  outputs =
    { nixpkgs, ... }:
    let
      pkgs = import nixpkgs {
        system = "x86_64-linux";
      };
      withJdk =
        jdk:
        pkgs.mkShellNoCC {
          packages = [
            jdk
            (pkgs.maven.override {
              jdk_headless = jdk;
            })
            (pkgs.spring-boot-cli.override {
              jdk = jdk;
            })
          ];
        };
    in
    {
      devShells.x86_64-linux.default = withJdk pkgs.jdk21_headless;
      devShells.x86_64-linux.jdk24 = withJdk pkgs.jdk24_headless;
    };
}
