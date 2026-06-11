{ pkgs, ... }: let
  userChrome = builtins.readFile ./userChrome.css;
in {
  programs.librewolf = {
    enable = true;
    settings = {
      "webgl.disabled" = false;
      "privacy.resistFingerprinting" = false;
      "privacy.clearOnShutdown.history" = false;
      "privacy.clearOnShutdown.cookies" = false;
      "network.cookie.lifetimePolicy" = 0;
      "browser.fullscreen.autohide" = false;
    };
    profiles.default = {
      id = 0;
      name = "default";
      isDefault = true;
      userChrome = userChrome;
    };
  };

  home.file.".config/librewolf/sidebery-sidebar.css" = {
    source = ./sidebery-sidebar.css;
  };
}
