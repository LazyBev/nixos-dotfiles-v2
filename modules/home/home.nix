{ inputs, ... }: let
  vars = import ../../vars.nix;
in {
  flake.nixosModules.home = { config, lib, pkgs, ... }: {
    imports = [ inputs.home-manager.nixosModules.home-manager ];

    home-manager = {
      useGlobalPkgs = true;
      useUserPackages = true;
      users.${vars.username} = { pkgs, lib, ... }: {
        imports = [
          ./hm/user-dirs.nix
          ./hm/bat.nix
          ./hm/fzf.nix
          ./hm/theme.nix
          ./hm/vesktop.nix
          ./hm/xdg-config-files.nix
          ./hm/pictures.nix
        ];

        home.username = vars.username;
        home.homeDirectory = "/home/${vars.username}";
        home.stateVersion = "26.05";

        programs.home-manager.enable = true;

        home.activation.removeConflictingGtkFiles = lib.hm.dag.entryBefore ["checkLinkTargets"] ''
          rm -f /home/${vars.username}/.config/gtk-3.0/settings.ini /home/${vars.username}/.config/gtk-4.0/settings.ini
        '';
      };
    };
  };
}
