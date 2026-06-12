{ ... }: {
  imports = [
    ../modules/boot/bootloader.nix
    ../modules/boot/fonts.nix
    ../modules/boot/power-profiles.nix
    ../modules/boot/security.nix
    ../modules/boot/system.nix
    ../modules/boot/users.nix
  ];
}
