{ inputs, ... }: {
  flake.nixosModules.common = { config, lib, ... }: {
    options.gentuwu.hostType = lib.mkOption {
      type = lib.types.enum [ "desktop" "laptop" ];
      default = "desktop";
      description = "Whether this machine is a desktop or laptop";
    };

    imports = [
      ../core/boot
      ../core/power
      ../core/programs
      ../core/services
      ../home/apps
      ../home/services
      ../home/env
      ../home/fonts
      ../home/security.nix
      ../hosts/gentuwu/disk-desktop.nix
      ../hosts/gentuwu/nvidia-desktop.nix
      ../hosts/gentuwu-laptop/disk-laptop.nix
      ../hosts/gentuwu-laptop/nvidia-laptop.nix
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
