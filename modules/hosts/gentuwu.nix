{
  self,
  inputs,
  ...
}: let
  vars = import ../../vars.nix;
  mkGentuwu = extraModules:
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
  flake.nixosConfigurations.gentuwu = mkGentuwu [
    self.nixosModules.common
    {gentuwu.hostType = "desktop";}

    # ── Disk (desktop) ──────────────────────────────────────────────────────────
    ({ config, lib, vars, inputs, ... }: {
      imports = [ inputs.disko.nixosModules.disko ];

      config = lib.mkIf config.gentuwu.desktopHardware.enable {
        boot.initrd.availableKernelModules = [ "xhci_pci" "ahci" "nvme" "usbhid" "usb_storage" "sd_mod" ];
        boot.initrd.kernelModules = [ ];
        boot.kernelModules = [ "kvm-amd" ];
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
        hardware.cpu.amd.updateMicrocode = true;
      };
    })

    # ── Nvidia (desktop) ────────────────────────────────────────────────────────
    ({ config, lib, ... }: {
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
    })
  ];
}
