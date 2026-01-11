{
  config,
  pkgs,
  inputs,
  ...
}:
{
  imports = [
    ./hardware-configuration.nix
    ./modules/packettracer.nix
  ];

  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  programs.command-not-found.enable = true;

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.kernelPackages = pkgs.linuxKernel.packages.linux_6_12;

  networking.hostName = "nixos-max";

  networking.networkmanager.enable = true;
  networking.wireless.enable = false;
  networking.networkmanager = {
    settings = {
      connectivity = {
        uri = "http://connectivitycheck.gstatic.com/generate_204";
      };
    };
  };
  ###TEMP
  networking.firewall.enable = true;

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

  virtualisation = {
    docker.enable = true;
    libvirtd.enable = true;

    podman = {
      enable = true;
      defaultNetwork.settings.dns_enabled = true;
    };
  };

  programs.dconf.enable = true;

  services.blueman.enable = true;

  services.flatpak.enable = true;

  services.xserver = {
    enable = true;
    autoRepeatDelay = 200;
    autoRepeatInterval = 35;
    xkb.layout = "us,de";
    xkb.variant = "";
    videoDrivers = [
      "vmware"
      "nvidia"
    ];
  };

  services.qemuGuest.enable = true;

  services.displayManager.sddm.enable = true;
  services.desktopManager.plasma6.enable = true;

  services.printing.enable = true;

  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;
  };
  programs.wireshark.enable = true;

  # allow users in group "wireshark" to capture (dumpcap)
  programs.wireshark.dumpcap.enable = true;

  # optional: allow usbmon for USB capture
  # programs.wireshark.usbmon.enable = true;

  users.users.max = {
    isNormalUser = true;
    description = "max";
    extraGroups = [
      "networkmanager"
      "wheel"
      "docker"
      "libvirtd"
      "wireshark"
    ];
    packages = with pkgs; [
      kdePackages.kate
    ];

  };

  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true;
    dedicatedServer.openFirewall = true;
    localNetworkGameTransfers.openFirewall = true;
  };

  programs.nix-ld.enable = true;
  programs.nix-ld.libraries = with pkgs; [
    # Add any missing dynamic libraries for unpackaged programs
    # here, NOT in environment.systemPackages
  ];

  environment.systemPackages = with pkgs; [
    vim
    wget
    home-manager
    git
    pavucontrol
    vscode
    neovim
    gedit
    xdg-utils
    waypaper
    micro
    hyprland
    libreoffice-qt6
    jetbrains-toolbox
    jetbrains.idea
    kitty
    eww
    swww
    mako
    dunst
    libnotify
    hyprpaper
    swaybg
    wpaperd
    mpvpaper
    wofi
    fuzzel
    tofi
    bibata-cursors
    nerdfetch
    (prismlauncher.override {
      additionalPrograms = [ ffmpeg ];

      jdks = [
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
    protonup-ng
    starship
    btop
    brave
    librewolf
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
    ungoogled-chromium
    docker
    fishPlugins.foreign-env
    jetbrains.datagrip
    jetbrains.pycharm
    xfce.thunar
    tree
    traceroute
    wireshark
    screen
    usbutils
    whois
    helix
    dig
    dmenu
    swaynotificationcenter
    sddm-astronaut
    nwg-look
    bluez
    bluez-tools
    timeshift
    bleachbit
    gnome-disk-utility
    neohtop
    dysk
    brightnessctl
    tlp
    ranger
    tree
    ueberzug
    rofi-calc
    rofi-emoji
    redshift
    gpick
    gnome-calendar
    gnome-clocks
    android-studio
    github-cli
    docker-compose
    lazydocker
    postman
    shellcheck
    cloc
    fakeroot
    filezilla
    jq
    dbeaver-bin
    anydesk
    vlc
    mpd
    zip
    unzip
    gzip
    tmux
    graphviz
    google-java-format
    rstudio
    openvpn3
    virt-manager
    qemu
    libvirt
    virt-viewer
    bridge-utils
    galculator
    smile
    p7zip
    netcat
    snicat
    wireguard-tools
    unp
    gdb
    networkminer
    clang
    gcc
    gnumake
    zellij
    ocl-icd
    opencl-clhpp
    clinfo
    php
    freerdp
    dialog
    iproute2
    mysql-workbench
    gnupg
    pinentry-gnome3
    pkg-config
    libxml2.dev
    openssl.dev
    curl.dev
    freetype.dev
    fontconfig.dev
    R
    john
    cheese
    geogebra6
    warp
    dsniff
    nmap
    kotlin
    spotify
    gimp3
    gitkraken
    socat
    bun
    waybar
    swaylock
    hyprlock
    xdg-desktop-portal-hyprland
    xdg-desktop-portal-gtk
    wireplumber
    mongodb-compass
    imagemagick
    hollywood
    inputs.claude-desktop.packages.${system}.claude-desktop-with-fhs
    discord
  ];
  hardware.graphics = {
    enable = true;
  };
  hardware.nvidia.open = true;

  hardware.bluetooth = {
    enable = true;
    powerOnBoot = false;
  };

  fonts.packages = with pkgs; [
    nerd-fonts.jetbrains-mono
  ];

  programs.fish.enable = true;

  fonts.fontDir.enable = true;

  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
  };

  programs.hyprlock.enable = true;

  environment.sessionVariables = {
    WLR_NO_HARDWARE_CURSORS = "1";
    NIXOS_OZONE_WL = "1";
  };

  xdg.portal.enable = true;
  xdg.portal.extraPortals = [ pkgs.xdg-desktop-portal-gtk ];

  system.stateVersion = "25.05";

  # services.openssh.enable = true;
}
