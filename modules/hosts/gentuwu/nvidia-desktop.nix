{ config, lib, ... }: {
  options.gentuwu.nvidia.enable = lib.mkEnableOption "NVIDIA GPU configuration";

  config = lib.mkIf config.gentuwu.nvidia.enable {
    hardware.nvidia = {
      modesetting.enable = true;
      powerManagement.enable = false;
      powerManagement.finegrained = false;
      open = false;
      nvidiaSettings = true;
      package = config.boot.kernelPackages.nvidiaPackages.stable;
      prime = {
        sync.enable = true;
        amdgpuBusId = "PCI:13:0:0";
        nvidiaBusId = "PCI:1:0:0";
      };
    };
    services.xserver.videoDrivers = [ "nvidia" ];
    boot.kernelParams = [ "nvidia_drm.modeset=1" ];
  };
}
