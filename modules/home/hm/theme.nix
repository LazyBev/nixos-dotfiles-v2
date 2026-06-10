let
  vars = import ../../../vars.nix;
in { pkgs, ... }: {
  gtk = {
    enable = true;
    theme = {
      name = vars.theme;
      package = pkgs.dracula-theme;
    };
    iconTheme = {
      name = vars.theme;
      package = pkgs.dracula-icon-theme;
    };
    font = {
      name = vars.font;
      size = 10;
    };
    gtk2.force = true;
    gtk3.extraConfig.gtk-application-prefer-dark-theme = 1;
    gtk4.extraConfig.gtk-application-prefer-dark-theme = 1;
  };

  qt = {
    enable = true;
    platformTheme.name = "gtk";
    style = {
      name = vars.qtTheme;
      package = pkgs.adwaita-qt;
    };
  };

  dconf.settings."org/gnome/desktop/interface" = {
    color-scheme = "prefer-dark";
    gtk-theme = vars.theme;
    icon-theme = vars.theme;
    cursor-theme = vars.cursorTheme;
    cursor-size = vars.cursorSize;
    font-name = "${vars.font} 10";
  };
}
