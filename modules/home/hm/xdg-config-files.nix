{ ... }: {
  xdg.configFile."dunst/dunstrc".source                         = ../../../configs/apps/dunst/dunstrc;
  xdg.configFile."fuzzel/fuzzel.ini".source                     = ../../../configs/apps/fuzzel/fuzzel.ini;
  xdg.configFile."yazi/theme.toml".source                       = ../../../configs/apps/yazi/theme.toml;
  xdg.configFile."yazi/yazi.toml".source                        = ../../../configs/apps/yazi/yazi.toml;
  xdg.configFile."yazi/keymap.toml".source                      = ../../../configs/apps/yazi/keymap.toml;
  xdg.configFile."yazi/flavors/dracula.yazi/flavor.toml".source = ../../../configs/apps/yazi/flavors/dracula.yazi/flavor.toml;
  xdg.configFile."yazi/flavors/dracula.yazi/tmtheme.xml".source = ../../../configs/apps/yazi/flavors/dracula.yazi/tmtheme.xml;
  xdg.configFile."qutebrowser/config.py".source                 = ../../../configs/apps/qutebrowser/config.py;
  xdg.configFile."gtklock/style.css".source                     = ../../../configs/apps/gtklock/style.css;
  xdg.configFile."xdg-desktop-portal/portals.conf".text         = ''[preferred] default=gtk'';
}
