{
  config,
  pkgs,
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
  ];

  home.stateVersion = "25.05";

  programs.home-manager.enable = true;
}
