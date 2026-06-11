{inputs, ...}: let
  vars = import ../../../vars.nix;
  inherit (inputs.wrapper-modules.wrappers) niri noctalia-shell;
  inherit (builtins) fromJSON readFile;
in {
  perSystem = {
    pkgs,
    lib,
    self',
    ...
  }: let
    myNoctalia = noctalia-shell.wrap {
      inherit pkgs;
      settings = (fromJSON (readFile ../../../configs/apps/noctalia/noctalia.json)).settings;
    };
  in {
    packages.myNiri = niri.wrap {
      inherit pkgs;
      settings = {
        input = {
          keyboard.xkb = {
            layout = vars.keyboardLayout;
            options = "numpad:mac";
          };
          touchpad = {
            tap = {};
            natural-scroll = {};
          };
          mouse = {};
          trackpoint = {};
        };

        outputs = {
          "eDP-1" = {
            mode = "1920x1080@120.030";
            scale = 1.0;
            transform = "normal";
          };
        };

        layout = {
          gaps = 10;
          center-focused-column = "never";
          default-column-width.proportion = 1.0;
          focus-ring = {
            width = 2;
            active-color = "#bd93f9";
            inactive-color = "#44475a";
          };
          border.off = {};
          preset-column-widths = [
            {proportion = 0.5;}
            {proportion = 1.0;}
          ];
        };

        animations = {
          slowdown = 1.0;
        };

        workspaces = {
          "1" = {};
          "2" = {};
          "3" = {};
          "4" = {};
          "5" = {};
          "6" = {};
          "7" = {};
          "8" = {};
          "9" = {};
        };

        window-rules = [
          {
            geometry-corner-radius = 8;
            clip-to-geometry = true;
          }
          {
            matches = [
              {
                app-id = "zen$";
                title = "^Picture-in-Picture$";
              }
            ];
            open-floating = true;
          }
          {
            matches = [{title = "^Picture-in-Picture$";}];
            open-floating = true;
          }
          {
            matches = [{app-id = "^pavucontrol$";}];
            open-floating = true;
          }
          {
            matches = [{app-id = "^nm-connection-editor$";}];
            open-floating = true;
          }
          {
            matches = [{app-id = "^foot$";}];
            default-column-width.proportion = 0.5;
          }
          {
            matches = [{app-id = "^thunar$";}];
            default-column-width.proportion = 0.5;
          }
          {
            matches = [{app-id = "^mpv$";}];
            open-floating = true;
            default-column-width = {fixed = 640;};
            default-window-height = {fixed = 360;};
          }
        ];

        screenshot-path = "~/Pictures/Screenshots/Screenshot from %Y-%m-%d %H-%M-%S.png";

        prefer-no-csd = true;

        environment = {
          XDG_SESSION_TYPE = "wayland";
          XDG_CURRENT_DESKTOP = "niri";
          XDG_SESSION_DESKTOP = "niri";
          DISPLAY = ":1";
          GDK_BACKEND = "wayland";
          GTK_USE_PORTAL = "1";
          QT_QPA_PLATFORM = "wayland";
          QT_WAYLAND_DISABLE_WINDOWDECORATION = "1";
          QT_AUTO_SCREEN_SCALE_FACTOR = "1";
          ELECTRON_OZONE_PLATFORM_HINT = "wayland";
          MOZ_ENABLE_WAYLAND = "1";
          SDL_VIDEODRIVER = "wayland";
          CLUTTER_BACKEND = "wayland";
          _JAVA_AWT_WM_NONREPARENTING = "1";
          XDG_DESKTOP_PORTAL = "xdg-desktop-portal";
          XCURSOR_THEME = vars.cursorTheme;
          XCURSOR_SIZE = toString vars.cursorSize;
          WLR_NO_HARDWARE_CURSORS = "1";
        };

        spawn-at-startup = let
          inherit (lib) getExe;
        in [
          [(getExe pkgs.xwayland-satellite)]
          [(getExe myNoctalia)]
          [(getExe pkgs.fcitx5) "-d"]
          [(getExe pkgs.dunst)]
          [(getExe pkgs.bash) "-lc" "sleep 1 && ${getExe pkgs.networkmanagerapplet} --indicator"]
          [(getExe pkgs.bash) "-lc" "${getExe pkgs.swaybg} -i ~/Pictures/matikanefuku.png"]
        ];

        binds = let
          inherit (lib) getExe getExe';
        in {
          "Alt+Shift+Slash".show-hotkey-overlay = {};

          "Alt+Return".spawn-sh     = getExe pkgs.foot;                                   
          "Alt+Shift+Return".spawn-sh = "${getExe pkgs.foot} -e zellij";                  
          "Alt+B".spawn-sh          = getExe pkgs.qutebrowser;
          "Alt+Shift+B".spawn-sh    = getExe pkgs.librewolf;
          "Alt+T".spawn-sh          = "${getExe pkgs.foot} -e yazi";
          "Alt+Shift+T".spawn-sh    = getExe pkgs.thunar;
          "Alt+E".spawn-sh          = "${getExe pkgs.foot} -e nvim";
          "Alt+Shift+E".spawn-sh    = getExe pkgs.vscodium;
          "Alt+S".spawn-sh          = "${getExe pkgs.foot} -e rmpc";
          "Alt+Shift+S".spawn-sh    = getExe pkgs.steam;                                  
          "Alt+V".spawn-sh          = "${getExe pkgs.foot} -e btop";
          "Alt+Shift+V".spawn-sh    = getExe pkgs.vesktop;
          "Alt+D".spawn-sh          = getExe pkgs.fuzzel;                                 
          "Alt+Y".spawn-sh          = getExe pkgs.waypaper;                               

          # ── Session / system ───────────────────────────────────────────────────
          "Alt+Escape".spawn-sh     = "${getExe myNoctalia} ipc call sessionMenu toggle";
          "Mod+Shift+L".spawn-sh    = "${getExe pkgs.gtklock} -s /home/${vars.username}/.config/gtklock/style.css -b /home/${vars.username}/Pictures/matikanefuku.png";
          "Alt+Ctrl+P".spawn-sh     = "${getExe pkgs.doas} reboot";
          "Alt+Shift+P".spawn-sh    = "${getExe pkgs.doas} poweroff";
          "Alt+Shift+Backspace".quit = {};

          # ── Screenshots ────────────────────────────────────────────────────────
          "Alt+X".screenshot        = {};                                                  # region
          "Alt+Shift+X".screenshot-screen = {};                                            # fullscreen
          "Alt+Ctrl+X".screenshot-window  = {};                                            # window

          # ── Window management ──────────────────────────────────────────────────
          "Ctrl+Alt+Q".close-window = {};

          "Alt+H".focus-column-left  = {};
          "Alt+L".focus-column-right = {};
          "Alt+K".focus-window-up    = {};
          "Alt+J".focus-window-down  = {};

          "Alt+Shift+H".move-column-left  = {};
          "Alt+Shift+L".move-column-right = {};
          "Alt+Shift+K".move-window-up    = {};
          "Alt+Shift+J".move-window-down  = {};

          "Alt+Tab".toggle-window-floating = {};
          "Alt+Ctrl+Tab".focus-floating    = {};
          "Alt+Space".focus-tiling         = {};
          "Alt+F".fullscreen-window        = {};
          "Alt+W".switch-preset-column-width = {};

          "Alt+Minus".set-column-width       = "-10%";
          "Alt+Equal".set-column-width       = "+10%";
          "Alt+Shift+Minus".set-window-height = "-10%";
          "Alt+Shift+Equal".set-window-height = "+10%";

          "Alt+Comma".consume-window-into-column    = {};
          "Alt+Period".expel-window-from-column     = {};
          "Alt+BracketLeft".consume-or-expel-window-left  = {};
          "Alt+BracketRight".consume-or-expel-window-right = {};

          # ── Workspaces ─────────────────────────────────────────────────────────
          "Alt+1".focus-workspace = "1";
          "Alt+2".focus-workspace = "2";
          "Alt+3".focus-workspace = "3";
          "Alt+4".focus-workspace = "4";
          "Alt+5".focus-workspace = "5";
          "Alt+6".focus-workspace = "6";
          "Alt+7".focus-workspace = "7";
          "Alt+8".focus-workspace = "8";
          "Alt+9".focus-workspace = "9";
          "Alt+N".focus-workspace-up   = {};
          "Alt+M".focus-workspace-down = {};

          "Alt+Shift+1".move-column-to-workspace = "1";
          "Alt+Shift+2".move-column-to-workspace = "2";
          "Alt+Shift+3".move-column-to-workspace = "3";
          "Alt+Shift+4".move-column-to-workspace = "4";
          "Alt+Shift+5".move-column-to-workspace = "5";
          "Alt+Shift+6".move-column-to-workspace = "6";
          "Alt+Shift+7".move-column-to-workspace = "7";
          "Alt+Shift+8".move-column-to-workspace = "8";
          "Alt+Shift+9".move-column-to-workspace = "9";
          "Alt+Shift+N".move-column-to-workspace-up   = {};
          "Alt+Shift+M".move-column-to-workspace-down = {};

          # ── Media / volume ─────────────────────────────────────────────────────
          "XF86AudioRaiseVolume".spawn-sh  = "${getExe' pkgs.wireplumber "wpctl"} set-volume @DEFAULT_AUDIO_SINK@ 0.1+";
          "XF86AudioLowerVolume".spawn-sh  = "${getExe' pkgs.wireplumber "wpctl"} set-volume @DEFAULT_AUDIO_SINK@ 0.1-";
          "XF86AudioMute".spawn-sh         = "${getExe' pkgs.wireplumber "wpctl"} set-mute @DEFAULT_AUDIO_SINK@ toggle";
          "XF86AudioMicMute".spawn-sh      = "${getExe' pkgs.wireplumber "wpctl"} set-mute @DEFAULT_AUDIO_SOURCE@ toggle";
          "XF86AudioPlay".spawn-sh         = "${getExe' pkgs.playerctl "playerctl"} play-pause";
          "XF86AudioNext".spawn-sh         = "${getExe' pkgs.playerctl "playerctl"} next";
          "XF86AudioPrev".spawn-sh         = "${getExe' pkgs.playerctl "playerctl"} previous";
          "Alt+Ctrl+Space".spawn-sh        = "${getExe' pkgs.playerctl "playerctl"} play-pause";
          "Alt+Ctrl+L".spawn-sh            = "${getExe' pkgs.playerctl "playerctl"} next";
          "Alt+Ctrl+H".spawn-sh            = "${getExe' pkgs.playerctl "playerctl"} previous";
        };
      };
    };

    packages.myNoctalia = myNoctalia;
  };
}
