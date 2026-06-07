{ inputs, config, lib, ... }: {
  imports = [ inputs.disko.nixosModules.disko ];

  options.gentuwu.desktopHardware.enable = lib.mkEnableOption "gentuwu desktop hardware configuration";

  config = lib.mkIf config.gentuwu.desktopHardware.enable {
    boot.initrd.availableKernelModules = [ "xhci_pci" "ahci" "nvme" "usbhid" "usb_storage" "sd_mod" ];
    boot.initrd.kernelModules = [ ];
    boot.kernelModules = [ "kvm-amd" "rtw88_8822ce" ];
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
          root = {
            name = "root";
            label = "root";
            size = "467G";
            content = {
              type = "filesystem";
              format = "ext4";
              mountpoint = "/";
            };
          };
          swap = {
            name = "swap";
            label = "swap";
            size = "100%";
            content = {
              type = "swap";
              discardPolicy = "both";
            };
          };
        };
      };
    };

    hardware.enableRedistributableFirmware = true;
    nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
    hardware.cpu.amd.updateMicrocode = true;
  };
}
