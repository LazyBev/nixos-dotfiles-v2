{ pkgs, ... }: {
  boot = {
    loader.systemd-boot = {
      enable = true;
      configurationLimit = 10;
      editor = false;
    };
    consoleLogLevel = 3;
    kernelParams = [
      "quiet" "udev.log_priority=3" "nowatchdog" "nmi_watchdog=0"
      "preempt=full" "slab_nomerge" "init_on_alloc=1" "page_alloc.shuffle=1"
    ];
    kernelPackages = pkgs.linuxPackages;
    kernel.sysctl = {
      "kernel.sysrq" = 1;
      "kernel.kptr_restrict" = 2;
      "kernel.dmesg_restrict" = 1;
      "fs.suid_dumpable" = 0;
      "net.core.rmem_max" = 16777216;
      "net.core.wmem_max" = 16777216;
    };
  };

  systemd.coredump.enable = false;
}
