{ pkgs, ... }:
{
  home.packages = with pkgs; [
    maven
    gradle
  ];
  programs.java = {
    enable = true;
    package = pkgs.jdk24;
  };
}
