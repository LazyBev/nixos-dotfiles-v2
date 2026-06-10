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
    ];
  };
}
