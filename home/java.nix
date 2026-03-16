{ pkgs, ... }:
{
  programs.java = {
    enable = true;
    package = pkgs.jdk21;
  };
  home.packages = with pkgs; [
    maven
    gradle
  ];

  programs.helix.extraPackages = [
    pkgs.jdt-language-server
  ];
}
