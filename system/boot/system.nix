{ vars, pkgs, ... }: {
  time.timeZone = "Europe/London";
  i18n.defaultLocale = "en_GB.UTF-8";
  services.xserver.xkb.layout = vars.keyboardLayout;
  console.keyMap = "uk";

  programs.git = {
    enable = true;
    config.safe.directory = "/home/yari/nixos-cfg";
  };

  networking.hostName = vars.hostname;
  networking.networkmanager.enable = true;
  networking.networkmanager.wifi.powersave = false;
  networking.firewall.allowPing = false;

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
    allowed-users = [ "root" "@users" ];
  };

  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 30d";
  };

  nix.optimise.automatic = true;

  system.autoUpgrade = {
    enable = true;
    allowReboot = false;
    dates = "weekly";
  };

  services.fail2ban.enable = true;
  services.omnisearch = {
    enable = true;
    settings.host = "127.0.0.1";
    settings.port = 8087;
  };

  environment.systemPackages = with pkgs; [
    bash git vim curl wget gnumake gcc clang
    fzf fd ripgrep jq eza bat zoxide
    fastfetch file p7zip unzip unar
    e2fsprogs dosfstools just dysk gh
    ffmpeg tealdeer devenv
  ];

  environment.variables = {
    GTK_THEME = vars.theme;
    XCURSOR_THEME = vars.cursorTheme;
    XCURSOR_SIZE = toString vars.cursorSize;
  };

  environment.sessionVariables = {
    GTK_THEME = vars.theme;
    QT_STYLE_OVERRIDE = vars.qtTheme;
    QT_QPA_PLATFORMTHEME = "gtk3";
    ADW_DISABLE_PORTAL = "1";
    TERMINAL = vars.terminal;
  };

  xdg.mime.defaultApplications."x-scheme-handler/terminal" = "${vars.terminal}.desktop";

  xdg.portal = {
    enable = true;
    extraPortals = with pkgs; [
      xdg-desktop-portal-gtk
      xdg-desktop-portal-gnome
    ];
    config.common.default = "gtk";
  };
}
