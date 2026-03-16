{ config, pkgs, ... }:
{
  home.packages = with pkgs; [
    kitty
    waybar
    rofi
    hyprlock
    xfce.thunar
    discord
    hyprshot
    brightnessctl
    playerctl
    smile
    librewolf
  ];

  programs.hyprlock.enable = true;

  wayland.windowManager.hyprland = {
    enable = true;
    systemd.enable = true;
    settings = {
      "$terminal" = "kitty";
      "$fileManager" = "thunar";
      "$menu" = "rofi -show combi -combi-modi window,drun,run";
      "$mainMod" = "SUPER";

      exec-once = [
        #Wayland wallpaper
        "swww-daemon"
        #Autostart Apps on Desktops
        "[workspace 1 silent] kitty"
        "[workspace 2 silent] firefox"
        "[workspace 10 ] discord"

        "waybar"
        "blueman-applet"
        "nm-applet --indicator"
      ];

      bind = [
        "ALT, Tab, cyclenext"
        # Fullscreen
        "$mainMod, D, fullscreen, 1"
        "$mainMod, F, fullscreen, 0"
        # EMOJI
        "$mainMod, period, exec, smile"
        # Hyprlock
        "$mainMod, L, exec, hyprlock"
        #Screenshot
        "$mainMod, G, exec, hyprshot -m region --clipboard-only --silent"
        "$mainMod, H, exec, hyprshot -m region      		 "
        "$mainMod, SUPER_L, exec, $menu"
        "$mainMod, Return, exec, $terminal"
        "$mainMod, Q, killactive,"
        "$mainMod, B, exec, librewolf -P school"
        "$mainMod, K, exec, librewolf -P personal"
        # $mainMod, M, exit,"
        "$mainMod, E, exec, $fileManager"
        "$mainMod, V, togglefloating,"
        "$mainMod, R, exec, $menu"
        "$mainMod, P, pseudo, # dwindle"
        "$mainMod, J, togglesplit, # dwindle"
        # Move focus with mainMod + arrow keys"
        "$mainMod, left, movefocus, l"
        "$mainMod, right, movefocus, r"
        "$mainMod, up, movefocus, u"
        "$mainMod, down, movefocus, d"
        # Switch workspaces with mainMod + [0-9]
        "$mainMod, 1, workspace, 1"
        "$mainMod, 2, workspace, 2"
        "$mainMod, 3, workspace, 3"
        "$mainMod, 4, workspace, 4"
        "$mainMod, 5, workspace, 5"
        "$mainMod, 6, workspace, 6"
        "$mainMod, 7, workspace, 7"
        "$mainMod, 8, workspace, 8"
        "$mainMod, 9, workspace, 9"
        "$mainMod, 0, workspace, 10"
        # Move active window to a workspace with mainMod + SHIFT + [0-9]""
        "$mainMod SHIFT, 1, movetoworkspace, 1"
        "$mainMod SHIFT, 2, movetoworkspace, 2"
        "$mainMod SHIFT, 3, movetoworkspace, 3"
        "$mainMod SHIFT, 4, movetoworkspace, 4"
        "$mainMod SHIFT, 5, movetoworkspace, 5"
        "$mainMod SHIFT, 6, movetoworkspace, 6"
        "$mainMod SHIFT, 7, movetoworkspace, 7"
        "$mainMod SHIFT, 8, movetoworkspace, 8"
        "$mainMod SHIFT, 9, movetoworkspace, 9"
        "$mainMod SHIFT, 0, movetoworkspace, 10"
        # Example special workspace (scratchpad)""
        "$mainMod, S, togglespecialworkspace, magic"
        "$mainMod SHIFT, S, movetoworkspace, special:magic"
        # Scroll through existing workspaces with mainMod + scroll"
        "$mainMod, mouse_down, workspace, e+1"
        "$mainMod, mouse_up, workspace, e-1"
      ];
      # Move/resize windows with mainMod + LMB/RMB and dragging
      bindm = [
        "$mainMod, mouse:272, movewindow"
        "$mainMod, mouse:273, resizewindow"
      ];
      # Laptop multimedia keys for volume and LCD brightness
      bindel = [
        ",XF86AudioRaiseVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+"
        ",XF86AudioLowerVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"
        ",XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"
        ",XF86AudioMicMute, exec, wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"
        ",XF86MonBrightnessUp, exec, brightnessctl set 5%+"
        ",XF86MonBrightnessDown, exec, brightnessctl set 5%"
      ];
      # Requires playerctl
      bindl = [
        ", XF86AudioNext, exec, playerctl next"
        ", XF86AudioPause, exec, playerctl play-pause"
        ", XF86AudioPlay, exec, playerctl play-pause"
        ", XF86AudioPrev, exec, playerctl previous"
      ];
      monitor = [
        ",highres, 0x0,1,mirror, eDP-1 "
        "eDP-1,highres, 0x0, 1"
      ];
      #Environment Variables
      env = [
        "GDK_SCALE,1"
        "XCURSOR_SIZE,24"
        "HYPRCURSOR_SIZE,24"
        "_JAVA_AWT_WM_NONREPARENTING,1"
        "QT_AUTO_SCREEN_SCALE_FACTOR,1"
      ];
      general = {
        gaps_in = 0;
        gaps_out = 0;
        border_size = 1;
        resize_on_border = false;
        allow_tearing = false;
        layout = "dwindle";
      };
      decoration = {
        rounding = 0;
        rounding_power = 2;
        active_opacity = 1.0;
        inactive_opacity = 1.0;
        shadow = {
          enabled = true;
          range = 4;
          render_power = 3;
          color = "rgba(1a1a1aee)";
        };
        blur = {
          enabled = true;
          size = 3;
          passes = 1;
          vibrancy = 0.1;
        };
      };
      animations = {
        enabled = "yes please :)";
        bezier = [
          "easeOutQuint,0.23,1,0.32,1"
          "easeInOutCubic,0.65,0.05,0.36,1"
          "linear,0,0,1,1"
          "almostLinear,0.5,0.5,0.75,1.0"
          "quick,0.15,0,0.1,1"
        ];
        animation = [
          "global, 1, 10, default"
          "border, 1, 5.39, easeOutQuint"
          "windows, 1, 4.79, easeOutQuint"
          "windowsIn, 1, 4.1, easeOutQuint, popin 87%"
          "windowsOut, 1, 1.49, linear, popin 87%"
          "fadeIn, 1, 1.73, almostLinear"
          "fadeOut, 1, 1.46, almostLinear"
          "fade, 1, 3.03, quick"
          "layers, 1, 3.81, easeOutQuint"
          "layersIn, 1, 4, easeOutQuint, fade"
          "layersOut, 1, 1.5, linear, fade"
          "fadeLayersIn, 1, 1.79, almostLinear"
          "fadeLayersOut, 1, 1.39, almostLinear"
          "workspaces, 1, 1.94, almostLinear, fade"
          "workspacesIn, 1, 1.21, almostLinear, fade"
          "workspacesOut, 1, 1.94, almostLinear, fade"
        ];
      };
      workspace = [
        "w[tv1], gapsout:0, gapsin:0"
        "f[1], gapsout:0, gapsin:0"
      ];
      windowrulev2 = [
        "bordersize 0, floating:0, onworkspace:w[tv1]"
        "rounding 0, floating:0, onworkspace:w[tv1]"
        "bordersize 0, floating:0, onworkspace:f[1]"
        "tile,class:librewolf,title:File Upload"
        "rounding 0, floating:0, onworkspace:f[1]"
        # Ignore maximize requests from apps. You'll probably like this.
        "suppressevent maximize, class:.*"
        # Fix some dragging issues with XWayland
        "nofocus,class:^$,title:^$,xwayland:1,floating:1,fullscreen:0,pinned:0"
        #windowrulev2 = float,class:^(kitty)$,title:^(kitty)$
      ];
      dwindle = {
        pseudotile = "yes";
        preserve_split = "yes";
      };
      master.new_status = "master";
      misc = {
        force_default_wallpaper = 0;
        disable_hyprland_logo = true;
      };
      input = {
        kb_layout = "us,de";
        kb_variant = "";
        kb_model = "";
        kb_options = "";
        kb_rules = "";
        touchpad = {
          natural_scroll = true;
          disable_while_typing = true;
        };
        follow_mouse = 1;
        sensitivity = 0.5; # -1.0 - 1.0, 0 means no modification.
      };
      device = {
        name = "epic-mouse-v1";
        sensitivity = -0.5;
      };
      xwayland = {
        force_zero_scaling = true;
      };
    };
  };
}
