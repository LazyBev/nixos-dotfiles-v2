{ inputs, config, lib, vars, ... }: {
  imports = [ inputs.disko.nixosModules.disko ];

  options.gentuwu.laptopHardware.enable = lib.mkEnableOption "gentuwu laptop hardware configuration";

  config = lib.mkIf config.gentuwu.laptopHardware.enable {
    boot.initrd.availableKernelModules = [ "vmd" "xhci_pci" "nvme" "usb_storage" "sd_mod" ];
    boot.initrd.kernelModules = [ ];
    boot.kernelModules = [ "kvm-intel" "rtw88_8822ce" ];
    boot.extraModulePackages = [ ];

    disko.devices.disk.nvme0n1 = {
      type = "disk";
      device = "/dev/nvme0n1";
      content = {
        type = "gpt";
        partitions = {
          boot = {
            name = "EFI";
            label = "EFI";
            size = "1G";
            type = "EF00";
            content = {
              type = "filesystem";
              format = "vfat";
              mountpoint = "/boot";
              mountOptions = [ "fmask=0077" "dmask=0077" ];
            };
          };
          swap = {
            name = "swap";
            label = "swap";
            size = "16G";
            content = {
              type = "swap";
              discardPolicy = "both";
            };
          };
          root = {
            name = "root";
            label = "root";
            size = "100%";
            content = {
              type = "filesystem";
              format = "ext4";
              mountpoint = "/";
            };
          };
        };
      };
    };

    nixpkgs.hostPlatform = lib.mkDefault vars.platform;
    hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;

    services.upower.enable = true;
  };
}
