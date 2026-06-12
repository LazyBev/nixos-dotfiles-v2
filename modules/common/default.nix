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
    options.gentuwu.desktopHardware.enable = lib.mkEnableOption "gentuwu desktop hardware configuration";
    options.gentuwu.nvidia.enable = lib.mkEnableOption "NVIDIA GPU configuration";
    options.gentuwu.laptopHardware.enable = lib.mkEnableOption "gentuwu laptop hardware configuration";
    options.gentuwu.nvidiaLaptop.enable = lib.mkEnableOption "NVIDIA GPU (laptop) configuration";
    imports = [
      inputs.nur.modules.nixos.default
      ../core/boot.nix
      ../home/apps.nix
      ../home/services.nix
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
