{self, inputs, ...}: let
  vars = import ../../shared/vars.nix;
  inherit (inputs.wrapper-modules.wrappers) noctalia-shell;
  inherit (builtins) fromJSON readFile;
in {
  flake.nixosModules.dwlPackages = { pkgs, self, lib, config, ... }: let
    system = pkgs.stdenv.hostPlatform.system;
    cfg = config.programs.dwl;
  in {
    config = lib.mkMerge [
      {
        programs.dwl = {
          enable = true;
          package = lib.mkDefault pkgs.dwl;
        };
      }
      (lib.mkIf cfg.enable {
        environment.systemPackages = with pkgs; [
          grim slurp wmenu playerctl dunst fcitx5 networkmanagerapplet
          alacritty zellij qutebrowser librewolf thunar yazi
          vscodium rmpc steam vesktop btop waypaper gtklock
          swaybg xwayland-satellite wmenu
        ];

        programs.dwl.extraSessionCommands = ''
          export XDG_SESSION_TYPE=wayland
          export XDG_CURRENT_DESKTOP=dwl
          export XDG_SESSION_DESKTOP=dwl
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
          export WLR_NO_HARDWARE_CURSORS=1

          ${pkgs.dunst}/bin/dunst &
          ${pkgs.fcitx5}/bin/fcitx5 -d &
          ${pkgs.networkmanagerapplet}/bin/nm-applet --indicator &
          ${pkgs.xwayland-satellite}/bin/xwayland-satellite &
          ${pkgs.swaybg}/bin/swaybg -i ~/Pictures/matikanefuku.png &
        '';
      })
    ];
  };

  perSystem = {
    pkgs,
    lib,
    self',
    ...
  }: let
    myNoctalia = noctalia-shell.wrap {
      inherit pkgs;
      settings = (fromJSON (readFile ../configs/apps/noctalia/noctalia.json)).settings;
    };
  in {
    packages.dwl-session = pkgs.writeShellScriptBin "dwl-session" ''
      export XDG_SESSION_TYPE=wayland
      export XDG_CURRENT_DESKTOP=dwl
      export XDG_SESSION_DESKTOP=dwl
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
      export WLR_NO_HARDWARE_CURSORS=1

      ${pkgs.dunst}/bin/dunst &
      ${pkgs.fcitx5}/bin/fcitx5 -d &
      ${myNoctalia}/bin/noctalia-shell &
      ${pkgs.networkmanagerapplet}/bin/nm-applet --indicator &
      ${pkgs.xwayland-satellite}/bin/xwayland-satellite &
      ${pkgs.swaybg}/bin/swaybg -i ~/Pictures/matikanefuku.png &

      exec ${pkgs.dwl}/bin/dwl "$@"
    '';


    devShells.dwl = pkgs.mkShell {
      packages = with pkgs; [
        gcc gnumake pkg-config wayland-scanner
        wayland wayland-protocols wlroots
        libinput libxkbcommon pixman
        libx11 libxcb libxcb-wm xwayland
      ];
      shellHook = ''
        echo "dwl dev shell — C build deps available"
      '';
    };
  };
}
