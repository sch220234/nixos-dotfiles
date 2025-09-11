{ config, ... }:
{
  programs.fish = {
    enable = true;

    shellInit = ''
      			set -g fish_greeting "Neel: Zzzzzzzzzz"
      			starship init fish | source
      		'';
    shellAliases = {
      snrs = "git -C /home/max/nixos-dotfiles add . && sudo nixos-rebuild switch --flake /home/max/nixos-dotfiles";
    };
  };
}
