{config, ...}:
{
	programs.git = {
		enable = true;

		userName = "patsch";
		userEmail = "sch220234@spengergasse.at";

		extraConfig.init.defaultBranch = "main";
	};
	home.file.".gitconfig".text = ''
	    [user]
	        name = patsch
	        email = scch220234@spengergasse.at
	    [init]
	        defaultBranch = main
	  '';
}
