{ pkgs, ... }: let
  userChrome = builtins.readFile ../configs/apps/librewolf/userChrome.css;

  overrides = ''
    pref("toolkit.legacyUserProfileCustomizations.stylesheets", true);
    pref("webgl.disabled", true);
    pref("privacy.resistFingerprinting", true);
    pref("privacy.clearOnShutdown.history", true);
    pref("network.cookie.lifetimePolicy", 3);
    pref("network.cookie.lifetime.days", 5);
    pref("browser.fullscreen.autohide", false);
  '';
in {
  programs.librewolf = {
    enable = true;
    profiles.default = {
      id = 0;
      name = "default";
      isDefault = true;
      userChrome = userChrome;
      extensions = {
        packages = with pkgs.nur.repos.rycee.firefox-addons; [
          ublock-origin sponsorblock return-youtube-dislikes darkreader sidebery vimium
        ];
        force = true;
      };

      settings."extensions.autoDisableScopes" = 0;

      search = {
        force = true;
        default = "OmniSearch";
        engines = {
          "OmniSearch" = {
            urls = [{
              template = "http://localhost:8087/search";
              params = [{name = "q"; value = "{searchTerms}";}];
            }];
            icon = "http://localhost:8087/static/favicon.ico";
            updateInterval = 24 * 60 * 60 * 1000;
            definedAliases = ["@os"];
          };
        };
      };
    };
  };

  home.file.".librewolf/librewolf.overrides.cfg".text = overrides;
  xdg.configFile."librewolf/sidebery-sidebar.css".source = ../configs/apps/librewolf/sidebery-sidebar.css;
}
