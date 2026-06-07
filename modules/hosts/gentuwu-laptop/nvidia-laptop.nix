{ config, lib, ... }: {
  options.gentuwu.nvidiaLaptop.enable = lib.mkEnableOption "NVIDIA GPU (laptop) configuration";

  config = lib.mkIf config.gentuwu.nvidiaLaptop.enable {
    hardware.nvidia = {
      modesetting.enable = true;
      powerManagement.enable = false;
      powerManagement.finegrained = false;
      open = false;
      nvidiaSettings = true;
      package = config.boot.kernelPackages.nvidiaPackages.stable;
      prime = {
        sync.enable = true;
        intelBusId = "PCI:0:2:0";
        nvidiaBusId = "PCI:1:0:0";
      };
    };
    services.xserver.videoDrivers = [ "nvidia" ];
    boot.kernelParams = [ "nvidia_drm.modeset=1" ];
  };
}
