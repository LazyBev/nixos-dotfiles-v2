{ vars, pkgs, ... }: {
  boot = {
    loader.systemd-boot = {
      enable = true;
      configurationLimit = 10;
    };
    consoleLogLevel = 3;
    kernelParams = [
      "quiet" "udev.log_priority=3" "nowatchdog" "nmi_watchdog=0"
      "preempt=full" "slab_nomerge" "init_on_alloc=1" "page_alloc.shuffle=1"
    ];
    kernelPackages = pkgs.linuxPackages;
    kernel.sysctl = {
      "kernel.sysrq" = 1;
      "net.core.rmem_max" = 134217728;
      "net.core.wmem_max" = 134217728;
    };
  };

  time.timeZone = "Europe/London";
  i18n.defaultLocale = "en_GB.UTF-8";
  services.xserver.xkb.layout = vars.keyboardLayout;
  console.keyMap = "uk";

  networking.hostName = vars.hostname;
  networking.networkmanager.enable = true;
  networking.networkmanager.wifi.powersave = false;

  nix.settings = {
    experimental-features = [ "nix-command" "flakes" ];
    max-jobs = vars.maxJobs;
    max-substitution-jobs = 5;
    substituters = [
      "https://cache.nixos.org"
      "https://nix-community.cachix.org"
    ];
    trusted-public-keys = [
      "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
    ];
  };
  system.stateVersion = vars.stateVersion;

  users.users.root = { initialPassword = "changeme"; };
  users.users.${vars.username} = {
    isNormalUser = true;
    initialPassword = "changeme";
    shell = pkgs.fish;
    description = vars.fullname;
    extraGroups = [ "networkmanager" "wheel" ];
  };
}
