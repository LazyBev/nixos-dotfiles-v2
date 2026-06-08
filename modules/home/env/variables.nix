{ ... }: {
  environment = {
    variables = {
      GTK_THEME = "Dracula";
      XCURSOR_THEME = "catppuccin-mocha-mauve-cursors";
      XCURSOR_SIZE = "24";
    };

    sessionVariables = {
      GTK_THEME = "Dracula";
      QT_STYLE_OVERRIDE = "adwaita-dark";
      QT_QPA_PLATFORMTHEME = "gtk3";
      ADW_DISABLE_PORTAL = "1";
      TERMINAL = "foot";
    };
  };

  xdg.mime.defaultApplications."x-scheme-handler/terminal" = "foot.desktop";
}
