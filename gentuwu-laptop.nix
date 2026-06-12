{
  self,
  inputs,
  ...
}: let
  vars = import ./vars.nix;
  mkGentuwuLaptop = extraModules:
    inputs.nixpkgs.lib.nixosSystem {
      specialArgs = {inherit inputs self vars;};
      modules =
        extraModules
        ++ [
          {nixpkgs.config.allowUnfree = true;}
          self.nixosModules.home
        ];
    };
in {
  flake.nixosConfigurations.gentuwu-laptop = mkGentuwuLaptop [
    self.nixosModules.common
    {gentuwu.hostType = "laptop";}

    # ── Disk (laptop) ───────────────────────────────────────────────────────────
    ({ config, lib, vars, inputs, ... }: {
      imports = [ inputs.disko.nixosModules.disko ];

      config = lib.mkIf config.gentuwu.laptopHardware.enable {
        boot.initrd.availableKernelModules = [ "vmd" "xhci_pci" "nvme" "usb_storage" "sd_mod" ];
        boot.initrd.kernelModules = [ ];
        boot.kernelModules = [ "kvm-intel" ];
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

        hardware.enableRedistributableFirmware = true;
        nixpkgs.hostPlatform = lib.mkDefault vars.platform;
        hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;

        services.upower.enable = true;
      };
    })

    # ── Nvidia (laptop) ─────────────────────────────────────────────────────────
    ({ config, lib, ... }: {
      config = lib.mkIf config.gentuwu.nvidiaLaptop.enable {
        hardware.nvidia = {
          modesetting.enable = true;
          powerManagement.enable = false;
          powerManagement.finegrained = false;
          open = false;
          nvidiaSettings = false;
          package = config.boot.kernelPackages.nvidiaPackages.stable;
          prime = {
            offload.enable = true;
            intelBusId = "PCI:0:2:0";
            nvidiaBusId = "PCI:1:0:0";
          };
        };
        services.xserver.videoDrivers = [ "nvidia" ];
        boot.kernelParams = [ "nvidia_drm.modeset=1" ];
      };
    })
  ];
}
