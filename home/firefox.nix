{ extensions, ... }:
{
  programs.firefox = {
    enable = true;
    languagePacks = [ "en-US" ];
    policies = {
      DisableTelemetry = true;
      DisableFirefoxStudies = true;
      DisablePocket = true;
      DisableFirefoxAccounts = true;
      DisableAccounts = true;
      DontCheckDefaultBrowser = true;
      DisplayBookmarksToolbar = "always";
      OfferToSaveLogins = false;
      PasswordManagerEnabled = false;

      ExtensionSettings = {
        "*".installation_mode = "force_installed";
      };
    };

    profiles.default = {
      settings = {
        "sidebar.verticalTabs" = true;
        "browser.startup.page" = 3;
        "ui.highlight" = "blue";
        "ui.highlighttext" = "#002d75";
      };
      bookmarks = {
        force = true;
        settings = [
          {
            name = "wikipedia";
            tags = [ "wiki" ];
            keyword = "+wiki";
            url = "https://en.wikipedia.org/wiki/Special:Search?search=%s&go=Go";
          }
          {
            name = "nixpkgs";
            tags = [
              "nixpkgs"
              "package"
            ];
            keyword = "+np";
            url = "https://search.nixos.org/packages?channel=25.05&query=%s";
          }
          {
            name = "nixos options";
            tags = [
              "nixos"
              "options"
            ];
            keyword = "+no";
            url = "https://search.nixos.org/options?channel=25.05&query=%s";
          }
          {
            name = "outlook";
            url = "https://outlook.office365.com/mail/";
          }
          {
            name = "teams";
            url = "https://teams.microsoft.com/v2/";
          }
          {
            name = "schooltodo";
            url = "https://trello.com/b/7xmnUdsK/school-todo";
          }
          {
            name = "grep-app";
            url = "https://grep.app/search?f.lang=Nix&q=bookmarks";
          }
          {
            name = "hm options";
            url = "https://home-manager-options.extranix.com/?channel=25.05&query=";
          }
        ];
      };

      containersForce = true;
      extensions = {
        force = true;
        packages = with extensions; [
          ublock-origin
          firefox-color
          tree-style-tab
          darkreader
          bitwarden
          sponsorblock
        ];
      };
      search.force = true;
    };
  };
}
