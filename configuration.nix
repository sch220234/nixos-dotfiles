# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:
{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  #home.enableNixpkgsReleaseCheck = true;
 # home-manager.useUserPackages = true;
  #home-manager.useGlobalPkgs = true;
  #home-manager.backupFileExtension = "backup";
  #home-manager.users.max = import ./home.nix
  
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  programs.command-not-found.enable = true;

    
  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "nixos-max"; # Define your hostname.

  networking.networkmanager.enable = true;
  networking.wireless.enable = false;

  time.timeZone = "Europe/Vienna";

  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "de_AT.UTF-8";
    LC_IDENTIFICATION = "de_AT.UTF-8";
    LC_MEASUREMENT = "de_AT.UTF-8";
    LC_MONETARY = "de_AT.UTF-8";
    LC_NAME = "de_AT.UTF-8";
    LC_NUMERIC = "de_AT.UTF-8";
    LC_PAPER = "de_AT.UTF-8";
    LC_TELEPHONE = "de_AT.UTF-8";
    LC_TIME = "de_AT.UTF-8";
  };

  virtualisation.docker.enable = true;
  

  # Enable the X11 windowing system.
  # You can disable this if you're only using the Wayland session.
  services.xserver = {
  	enable = true;
  	autoRepeatDelay = 200;
  	autoRepeatInterval = 35;
  	xkb.layout = "us";
  	xkb.variant = "";
  };

  # Enable the KDE Plasma Desktop Environment.
  services.displayManager.sddm.enable = true;
  services.desktopManager.plasma6.enable = true;

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound with pipewire.
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;
  };
  
  users.users.max = {
    isNormalUser = true;
    description = "max";
    extraGroups = [ "networkmanager" "wheel" "docker"];
    packages = with pkgs; [
      kdePackages.kate   
     ];
    
  };

  # Java
  programs.java = {
  	enable = true;
  	package = pkgs.jdk24;
  };

  

  # Install firefox.
  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true; # Optional: for Steam Remote Play
    dedicatedServer.openFirewall = true; # Optional: for Source Dedicated Server
    localNetworkGameTransfers.openFirewall = true; # Optional: for local network game transfers
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;


  environment.systemPackages = with pkgs; [
    vim
    wget
    home-manager
	git
	openjdk21
	pavucontrol
	firefox
	fish
	jre21_minimal
	jre_minimal
	jdk
	jdk24
	vscode
	neovim
	gedit
	xdg-utils
	waypaper
	vim
	micro
	hyprland
	libreoffice-qt6
	jetbrains-toolbox
	jetbrains.idea-ultimate
	kitty
	waybar
	(waybar.overrideAttrs (oldAttrs: {
		mesonFlags = oldAttrs.mesonFlags ++ [ "-Dexperimental=true" ];
		})
	)
	eww
	swww
	mako
	dunst
	libnotify
	hyprpaper
	swaybg
	wpaperd
	mpvpaper
	rofi-wayland
	wofi
	fuzzel
	tofi
	bibata-cursors
	nerdfetch
	prismlauncher
	(prismlauncher.override {
		additionalPrograms = [ffmpeg];

		jdks = [
			graalvm-ce
			zulu8
			zulu17
			zulu
		];
	})
	nerd-fonts.jetbrains-mono
	nerd-fonts.fira-code
	steam
	steam-run
	alsa-utils
	alacritty
	alacritty-theme
	zed
	vscodium
	vscode
	kdePackages.kate
	grim
	grimblast
	wl-clipboard
    slurp
    swappy
    hyprshot
    hyprlock
    hypridle
    xwayland
    nixd
    git-lfs
    direnv
    gradle
    maven
    kdePackages.kdesu
    pipewire
    playerctl
    qt6.qtwayland
    font-manager
    lxappearance
    gamescope
    protonup
    starship
    btop
    brave
    librewolf
    vesktop
    minecraftia
    atlauncher
    python314
    pipx
    python3Packages.pip
    obsidian
    networkmanagerapplet
    gnome-control-center
    lf
    jetbrains.webstorm
    nodejs_24
    mysql84
    chromium
    docker
    fishPlugins.foreign-env
    jetbrains.datagrip
    jetbrains.pycharm-professional
    postman
  ];

  fonts.packages = with pkgs; [
  	nerd-fonts.jetbrains-mono
  ];
  
  programs.firefox.enable = true;
	
  programs.fish.enable = true;

  #Fonts
  fonts.fontDir.enable = true;
  

  #Hyprland
  programs.hyprland = {
	enable = true;
	xwayland.enable = true;
  };

  environment.sessionVariables = {
	WLR_NO_HARDWARE_CURSORS = "1";
	NIXOS_OZONE_WL = "1";
  };

  hardware = {
	graphics.enable = true;
	nvidia.modesetting.enable = true;
	nvidia.open = false;
  };
  services.xserver.videoDrivers = ["nvidia"];
  

  #XDG
  xdg.portal.enable = true;
  xdg.portal.extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
	  
  system.stateVersion = "25.05";

}
