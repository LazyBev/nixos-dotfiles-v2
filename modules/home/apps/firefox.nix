{ pkgs, inputs, ... }: {
  programs.firefox = {
    enable = true;
    preferences = {
      "ui.systemUsesDarkTheme" = 1;
      "widget.content.allow-gtk-dark-theme" = 1;
      "widget.allow-gtk-dark-theme" = 1;
    };
  };
}
