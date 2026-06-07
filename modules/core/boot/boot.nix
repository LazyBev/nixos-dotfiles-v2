{ ... }: {
  boot = {
    loader = {
      systemd-boot.enable = true;
      systemd-boot.configurationLimit = 10;
    };
    consoleLogLevel = 3;
    kernelParams = [
      "quiet"
      "udev.log_priority=3"
      "nowatchdog"
      "nmi_watchdog=0"
    ];

    kernel.sysctl = {
      "vm.vfs_cache_pressure" = 50;
      "vm.swappiness" = 10;
      "vm.dirty_ratio" = 10;
      "vm.dirty_background_ratio" = 5;
      "kernel.sysrq" = 1;
      "net.core.rmem_max" = 134217728;
      "net.core.wmem_max" = 134217728;
    };
  };
}
