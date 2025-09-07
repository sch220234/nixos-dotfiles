{config, ...}:
{
	programs.git = {
		enable = true;

		userName = "patsch";
		userEmail = "sch220234@spengergasse.at";

		extraConfig.init.defaultBranch = "main";
	};
}
