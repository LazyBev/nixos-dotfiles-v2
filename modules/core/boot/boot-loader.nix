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
      "preempt=full"
      "slab_nomerge"
      "init_on_alloc=1"
      "page_alloc.shuffle=1"
    ];
  };
}
