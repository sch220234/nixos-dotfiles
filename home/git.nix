{ config, ... }:
{
  programs.git = {
    enable = true;

    settings = {
      user = {
        name = "Patrick Schmid";
        email = "sch220234@spengergasse.at";
      };
      init.defaultBranch = "main";
    };

    signing = {
      signByDefault = true;
      key = "${config.home.homeDirectory}/.ssh/id_ed25519.pub";
      format = "ssh";
    };
  };

}
