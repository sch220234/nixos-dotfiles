{config, pkgs, lib, ...}:
let
	dotfiles = "${config.home.homeDirectory}/nixos-dotfiles/config";
	create_symlink = path: config.lib.file.mkOutOfStoreSymLink path;
in
{
	imports = [
	];

	home.username = "max";
	home.homeDirectory = "/home/max";
	home.stateVersion = "25.05";

	programs.bash = {
		enable = true;
		shellAliases = {
			btw = "echo Max uses nixos, btw";
		};
	};
}
