{
  config,
  pkgs,
  lib,
  libs,
  ...
}:
let
  dotfiles = "${config.home.homeDirectory}/nixos-dotfiles/config";
  create_symlink = path: config.lib.file.mkOutOfStoreSymLink path;
in
{
  home.username = "max";
  home.homeDirectory = "/home/max";
  home.stateVersion = "25.11";

  imports = [
    ./hyprland.nix
    ./wine.nix
    ./firefox.nix
    ./git.nix
    ./r.nix
    ./uv.nix
    ./js.nix
    ./fish.nix
    ./helix.nix
    ./kitty.nix
    ./tmux.nix
    ./java.nix
  ];

  programs.home-manager.enable = true;
}
