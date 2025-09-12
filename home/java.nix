{ pkgs, ... }:
let
  wrapper = pkgs.rWrapper.override {
    packages = with pkgs.rPackages; [ languageserver ];
    #packages = with pkgs.
  };
in

{

  programs.helix.extraPackages = [ wrapper ];
  home.packages = [ wrapper ];
}
