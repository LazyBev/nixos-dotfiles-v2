{ config, lib, ... }: {
  options.gentuwu.laptopHardware.enable = lib.mkEnableOption "gentuwu laptop hardware configuration";

  config = lib.mkIf config.gentuwu.laptopHardware.enable {
    boot.initrd.availableKernelModules = [ "vmd" "xhci_pci" "nvme" "usb_storage" "sd_mod" ];
    boot.initrd.kernelModules = [ ];
    boot.kernelModules = [ "kvm-intel" "rtw88_8822ce" ];
    boot.extraModulePackages = [ ];

    fileSystems."/" = {
      device = "/dev/disk/by-uuid/77b33934-7cdf-4cd8-b189-de6bc87b3ddf";
      fsType = "ext4";
    };

    fileSystems."/boot" = {
      device = "/dev/disk/by-uuid/06A4-51D3";
      fsType = "vfat";
      options = [ "fmask=0077" "dmask=0077" ];
    };

    swapDevices = [
      { device = "/dev/disk/by-uuid/a0958f83-b9ab-44a1-a36a-1fde6ae655ac"; }
    ];

    nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
    hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;

    services.upower.enable = true;
  };
}
