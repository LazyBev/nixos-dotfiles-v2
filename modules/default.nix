{ ... }: {
  imports = [
    ../parts.nix
    ./overlays.nix
    ./home/wm/niri.nix
    ./home/wm/dwl.nix
    ./home/devshell/default.nix
    ./home/home.nix
    ./hosts/gentuwu.nix
    ./hosts/gentuwu-laptop.nix
    ./common
  ];
}
