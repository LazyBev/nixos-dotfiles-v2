{ pkgs, ... }: let
  userChrome = builtins.readFile ../../../configs/apps/librewolf/userChrome.css;
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
      "toolkit.legacyUserProfileCustomizations.stylesheets" = true;
    };
    profiles.default = {
      id = 0;
      name = "default";
      isDefault = true;
      userChrome = userChrome;
    };
  };
}
