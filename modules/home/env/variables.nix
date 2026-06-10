{ vars, ... }: {
  environment = {
    variables = {
      GTK_THEME = vars.theme;
      XCURSOR_THEME = vars.cursorTheme;
      XCURSOR_SIZE = toString vars.cursorSize;
    };

    sessionVariables = {
      GTK_THEME = vars.theme;
      QT_STYLE_OVERRIDE = vars.qtTheme;
      QT_QPA_PLATFORMTHEME = "gtk3";
      ADW_DISABLE_PORTAL = "1";
      TERMINAL = vars.terminal;
    };
  };

  xdg.mime.defaultApplications."x-scheme-handler/terminal" = "${vars.terminal}.desktop";
}
