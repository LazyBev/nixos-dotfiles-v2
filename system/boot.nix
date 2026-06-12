{ ... }: {
  imports = [
    ./boot/bootloader.nix
    ./boot/fonts.nix
    ./boot/power-profiles.nix
    ./boot/security.nix
    ./boot/system.nix
    ./boot/users.nix
  ];
}
