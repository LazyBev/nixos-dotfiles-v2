{
  inputs,
  self,
  ...
}: {
  flake.nixosModules.common = {
    config,
    lib,
    self,
    ...
  }: {
    options.gentuwu.hostType = lib.mkOption {
      type = lib.types.enum ["desktop" "laptop"];
      default = "desktop";
      description = "Whether this machine is a desktop or laptop";
    };
    imports = [
      ../core/boot.nix
      ../core/power.nix
      ../core/programs.nix
      ../core/services.nix
      ../home/apps.nix
      ../home/services.nix
      ../home/env.nix
      ../home/fonts.nix
      ../home/security.nix
      self.nixosModules.overlays
      self.nixosModules.niriPackages
    ];
    config = {
      gentuwu.powerProfiles.enable = lib.mkDefault true;
      gentuwu.powerProfiles.default = lib.mkDefault "performance";
      gentuwu.desktopHardware.enable = lib.mkDefault (config.gentuwu.hostType == "desktop");
      gentuwu.nvidia.enable = lib.mkDefault (config.gentuwu.hostType == "desktop");
      gentuwu.laptopHardware.enable = lib.mkDefault (config.gentuwu.hostType == "laptop");
      gentuwu.nvidiaLaptop.enable = lib.mkDefault (config.gentuwu.hostType == "laptop");
    };
  };
}
