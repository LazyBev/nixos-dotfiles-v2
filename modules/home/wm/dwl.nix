{self, inputs, ...}: let
  vars = import ../../../vars.nix;
  inherit (inputs.wrapper-modules.wrappers) noctalia-shell;
  inherit (builtins) fromJSON readFile;
in {
  flake.nixosModules.dwlPackages = { pkgs, self, ... }: {
    environment.systemPackages = with pkgs; [
      dwl grim slurp wmenu playerctl dunst fcitx5 networkmanagerapplet
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
            Comment=dwl Wayland compositor
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

      # Autostart
      ${pkgs.dunst}/bin/dunst &
      ${pkgs.fcitx5}/bin/fcitx5 -d &
      ${myNoctalia}/bin/noctalia-shell &
      ${pkgs.networkmanagerapplet}/bin/nm-applet --indicator &

      exec ${pkgs.dwl}/bin/dwl "$@"
    '';
  };
}
