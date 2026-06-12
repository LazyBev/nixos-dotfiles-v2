{self, inputs, ...}: let
  vars = import ../../../vars.nix;
  inherit (inputs.wrapper-modules.wrappers) noctalia-shell;
  inherit (builtins) fromJSON readFile;
in {
  flake.nixosModules.dwlPackages = { pkgs, self, ... }: {
    environment.systemPackages = with pkgs; [
      dwl grim slurp wmenu playerctl
    ];

    services.displayManager.sessionPackages =
      let
        system = pkgs.stdenv.hostPlatform.system;
        dwlDesktopFile = pkgs.writeTextFile {
          name = "dwl-desktop-entry";
          destination = "/share/wayland-sessions/dwl.desktop";
          text = ''
            [Desktop Entry]
            Name=dwl
            Comment=dwl Wayland compositor (niri-like)
            Exec=${self.packages.${system}.dwl-session}/bin/dwl-session
            Type=Application
          '';
        };
      in
      [ (pkgs.symlinkJoin {
          name = "dwl-session";
          paths = [ dwlDesktopFile ];
          passthru.providedSessions = [ "dwl" ];
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
      settings = (fromJSON (readFile ../../../configs/apps/noctalia/noctalia.json)).settings;
    };
  in {
    packages.dwl-session = pkgs.writeShellScriptBin "dwl-session" ''
      set -a
      XDG_SESSION_TYPE=wayland
      XDG_CURRENT_DESKTOP=dwl
      XDG_SESSION_DESKTOP=dwl
      GDK_BACKEND=wayland
      GTK_USE_PORTAL=1
      QT_QPA_PLATFORM=wayland
      QT_WAYLAND_DISABLE_WINDOWDECORATION=1
      QT_AUTO_SCREEN_SCALE_FACTOR=1
      ELECTRON_OZONE_PLATFORM_HINT=wayland
      MOZ_ENABLE_WAYLAND=1
      SDL_VIDEODRIVER=wayland
      CLUTTER_BACKEND=wayland
      _JAVA_AWT_WM_NONREPARENTING=1
      XDG_DESKTOP_PORTAL=xdg-desktop-portal
      XCURSOR_THEME=${vars.cursorTheme}
      XCURSOR_SIZE=${toString vars.cursorSize}
      unset DISPLAY
      WLR_NO_HARDWARE_CURSORS=1
      set +a

      ${myNoctalia}/bin/noctalia-shell &
      ${pkgs.networkmanagerapplet}/bin/nm-applet --indicator &
      ${pkgs.bash}/bin/bash -lc "sleep 1 && ${pkgs.swaybg}/bin/swaybg -i ~/Pictures/matikanefuku.png" &

      exec ${pkgs.dwl}/bin/dwl "$@"
    '';
  };
}
