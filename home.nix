{config, pkgs, ...}:

{
	home.username = "max";
	home.homeDirectory = "/home/max";
	programs.git.enable = true;
	home.stateVersion = "25.05";

	programs.bash = {
		enable = true;
		shellAliases = {
			btw = "echo I use nixos, btw";
		};
	};
}
