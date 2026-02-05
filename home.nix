{
  config,
  pkgs,
  lib,
  ...
}:
let
  dotfiles = "${config.home.homeDirectory}/nixos-dotfiles/config";
  create_symlink = path: config.lib.file.mkOutOfStoreSymLink path;
in
{
  imports = [
  ];

  home.username = "max";
  home.homeDirectory = "/home/max";
  home.stateVersion = "25.11";

  home.packages = [
    pkgs.nodejs_20
    pkgs.nodePackages."@angular/cli"
  ];

  programs.bash = {
    enable = true;
    shellAliases = {
      btw = "echo Max uses nixos, btw";
    };
  };
}
