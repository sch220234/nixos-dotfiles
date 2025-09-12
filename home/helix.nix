{ pkgs, ... }:
{
  programs.helix = {
    enable = true;
    defaultEditor = true;

    extraPackages = with pkgs; [
      nil
      nixd
      nixfmt-rfc-style
      jdt-language-server
      ty
      bash-language-server
      fish-lsp
      vscode-extensions.ecmel.vscode-html-css
      nodePackages.vscode-json-languageserver
      kotlin-language-server
      typescript-language-server
      yaml-yaml-language-server
    ];

    settings = {
      editor = {
        mouse = false;
        middle-click-paste = false;

        lsp.display-inlay-hints = true;
        lsp.inlay-hints-length-limit = 80;
      };

      keys.normal = {
        left = "no_op";
        right = "no_op";
        down = "no_op";
        up = "no_op";
      };
    };

    languages.language = [
      {
        name = "nix";
        formatter.command = "nixfmt";
        auto-format = true;
      }
    ];
  };
}
