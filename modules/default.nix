{ ... }: {
  imports = [
    ../parts.nix
    ./overlays/default.nix
    ./home/wm/niri.nix
    ./home/devshell/default.nix
    ./home/home.nix
    ./hosts/gentuwu/default.nix
    ./hosts/gentuwu-laptop/default.nix
    ./common
  ];
}
