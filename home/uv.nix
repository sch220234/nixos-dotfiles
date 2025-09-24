{
  pkgs,
  lib,
  config,
  ...
}:
let
  python = pkgs.python3.withPackages (
    p: with p; [
      pwntools
      requests
      angr
      flask
      z3-solver

      (callPackage ./libdebug.nix { })
    ]
  );
in
{
  home.packages = [ python ];
  home.shellAliases.py = lib.getExe python;

  programs.uv.enable = true;

  programs.helix.extraPackages = [
    pkgs.pyright
  ];
}
