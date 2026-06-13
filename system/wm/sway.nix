{self, inputs, ...}: let
  vars = import ../../shared/vars.nix;
in {
  flake.nixosModules.swayPackages = { pkgs, self, lib, config, ... }: let
    cfg = config.programs.sway;
  in {
    config = lib.mkMerge [
      {
        programs.sway = {
          enable = true;
          package = lib.mkDefault pkgs.sway;
          extraSessionCommands = ''
            export XDG_SESSION_TYPE=wayland
            export XDG_CURRENT_DESKTOP=sway
            export XDG_SESSION_DESKTOP=sway
            export GDK_BACKEND=wayland
            export QT_QPA_PLATFORM=wayland
            export QT_WAYLAND_DISABLE_WINDOWDECORATION=1
            export QT_AUTO_SCREEN_SCALE_FACTOR=1
            export ELECTRON_OZONE_PLATFORM_HINT=wayland
            export MOZ_ENABLE_WAYLAND=1
            export SDL_VIDEODRIVER=wayland
            export CLUTTER_BACKEND=wayland
            export _JAVA_AWT_WM_NONREPARENTING=1
            export XCURSOR_THEME=${vars.cursorTheme}
            export XCURSOR_SIZE=${toString vars.cursorSize}
          '';
          extraOptions = [
            "--unsupported-gpu"
          ];
        };
      }
      (lib.mkIf cfg.enable {
        environment.systemPackages = with pkgs; [
          grim slurp wl-clipboard wl-color-picker jq
          dunst fcitx5 networkmanagerapplet
          alacritty zellij qutebrowser librewolf thunar yazi
          vscodium rmpc steam vesktop btop waypaper gtklock
          wmenu waybar swaybg xwayland-satellite pavucontrol brightnessctl
          playerctl swaylock swayidle wireplumber doas
        ];

        xdg.portal = {
          enable = true;
          wlr.enable = true;
          extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
        };
      })
    ];
  };

  perSystem = {
    pkgs,
    lib,
    self',
    ...
  }: {
    packages.sway-session = pkgs.writeShellScriptBin "sway-session" ''
      export XDG_SESSION_TYPE=wayland
      export XDG_CURRENT_DESKTOP=sway
      export XDG_SESSION_DESKTOP=sway
      export GDK_BACKEND=wayland
      export QT_QPA_PLATFORM=wayland
      export QT_WAYLAND_DISABLE_WINDOWDECORATION=1
      export QT_AUTO_SCREEN_SCALE_FACTOR=1
      export ELECTRON_OZONE_PLATFORM_HINT=wayland
      export MOZ_ENABLE_WAYLAND=1
      export SDL_VIDEODRIVER=wayland
      export CLUTTER_BACKEND=wayland
      export _JAVA_AWT_WM_NONREPARENTING=1
      export XCURSOR_THEME=${vars.cursorTheme}
      export XCURSOR_SIZE=${toString vars.cursorSize}

      exec ${pkgs.sway}/bin/sway --unsupported-gpu "$@"
    '';
  };
}
