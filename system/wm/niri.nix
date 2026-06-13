{self, inputs, ...}: let
  vars = import ../../shared/vars.nix;
  inherit (inputs.wrapper-modules.wrappers) noctalia-shell;
  inherit (builtins) fromJSON readFile;
in {
  flake.nixosModules.niriPackages = { pkgs, self, lib, config, ... }: let
    cfg = config.programs.niri;
  in {
    config = lib.mkMerge [
      {
        programs.niri = {
          enable = true;
          package = lib.mkDefault pkgs.niri;
        };
      }
      (lib.mkIf cfg.enable {
        environment.systemPackages = with pkgs; [
          fuzzel gtklock networkmanagerapplet swaybg
          waypaper xwayland-satellite
          alacritty zellij
          thunar thunar-archive-plugin thunar-volman tumbler
          yazi
          qutebrowser
          mpv rmpc playerctl
          btop cava
          vscodium
          steam
        ];
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
    packages.myNoctalia = myNoctalia;

    devShells.niri = pkgs.mkShell {
      packages = with pkgs; [
        rustc cargo rust-analyzer clippy rustfmt
        pkg-config wayland libxkbcommon
        libinput udev libglvnd mesa pixman pipewire
      ];
      shellHook = ''
        echo "niri dev shell — Rust build deps available"
      '';
    };
  };
}
