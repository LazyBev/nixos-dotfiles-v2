let
  vars = import ../../../vars.nix;
in { pkgs, ... }: let
  gtkPackage = {
    dracula = pkgs.dracula-theme;
    caelus = pkgs.caelus-theme;
  }.${vars.systemTheme};
  iconPackage = {
    dracula = pkgs.dracula-icon-theme;
    caelus = pkgs.dracula-icon-theme;
  }.${vars.systemTheme};
in {
  gtk = {
    enable = true;
    theme = {
      name = vars.theme;
      package = gtkPackage;
    };
    iconTheme = {
      name = vars.theme;
      package = iconPackage;
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
