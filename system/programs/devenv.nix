{ pkgs, config, ... }: {
  packages = with pkgs; [
    nixpkgs-fmt
    nixd
    statix
    deadnix
    nil
  ];

  scripts.check.exec = "nix flake check";
  scripts.update.exec = "nix flake update";
  scripts.build.exec = "doas nixos-rebuild switch --flake .#gentuwu";
  scripts.clean.exec = "doas nix-collect-garbage -d && nix-collect-garbage -d";
  scripts.lint.exec = "nix flake check";

  enterShell = ''
    echo "nixos-cfg devenv"
    echo "  check  → nix flake check"
    echo "  build  → nixos-rebuild switch"
    echo "  update → nix flake update"
    echo "  clean  → nix-collect-garbage"
    echo "  lint   → nix flake check"
  '';
}
