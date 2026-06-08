{ pkgs, ... }: let
  borePatch = pkgs.fetchpatch {
    url = "https://raw.githubusercontent.com/firelzrd/bore-scheduler/main/patches/stable/linux-6.18-bore/0001-linux6.18.22-bore-6.6.3.patch";
    hash = "sha256-beFQ06RD3q6ZkUh2ocRF98y66DmSgyQUbjWCGrsBQyU=";
  };
in {
  boot.kernelPatches = [{
    name = "bore-scheduler";
    patch = borePatch;
    extraConfig = ''
      SCHED_CLASS_EXT y
    '';
  }];
}
