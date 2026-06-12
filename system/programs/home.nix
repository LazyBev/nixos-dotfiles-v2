{ inputs, ... }: let
  vars = import ../../shared/vars.nix;
in {
  flake.nixosModules.home = { config, lib, pkgs, ... }: {
    imports = [ inputs.home-manager.nixosModules.home-manager ];

    home-manager = {
      useGlobalPkgs = true;
      useUserPackages = true;
      users.${vars.username} = { pkgs, lib, ... }: {
        imports = [
          ../home/bat.nix
          ../home/fzf.nix
          ../home/librewolf.nix
          ../home/vesktop.nix
          ../home/theme.nix
          ../home/xdg.nix
        ];

        home.username = vars.username;
        home.homeDirectory = "/home/${vars.username}";
        home.stateVersion = vars.stateVersion;

        programs.home-manager.enable = true;

        home.activation.removeConflictingGtkFiles = lib.hm.dag.entryBefore ["checkLinkTargets"] ''
          rm -f /home/${vars.username}/.config/gtk-3.0/settings.ini /home/${vars.username}/.config/gtk-4.0/settings.ini
        '';
      };
    };
  };
}
