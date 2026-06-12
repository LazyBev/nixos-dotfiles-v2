{...}: {
  xdg.configFile."dunst/dunstrc".source = ../../../configs/apps/dunst/dunstrc;
  xdg.configFile."fuzzel/fuzzel.ini".source = ../../../configs/apps/fuzzel/fuzzel.ini;
  xdg.configFile."yazi/theme.toml".source = ../../../configs/apps/yazi/theme.toml;
  xdg.configFile."yazi/yazi.toml".source = ../../../configs/apps/yazi/yazi.toml;
  xdg.configFile."yazi/keymap.toml".source = ../../../configs/apps/yazi/keymap.toml;
  xdg.configFile."yazi/flavors/dracula.yazi/flavor.toml".source = ../../../configs/apps/yazi/flavors/dracula.yazi/flavor.toml;
  xdg.configFile."yazi/flavors/dracula.yazi/tmtheme.xml".source = ../../../configs/apps/yazi/flavors/dracula.yazi/tmtheme.xml;
  xdg.configFile."qutebrowser/config.py".source = ../../../configs/apps/qutebrowser/config.py;
  xdg.configFile."librewolf/sidebery-sidebar.css".source = ../../../configs/apps/librewolf/sidebery-sidebar.css;
  xdg.configFile."gtklock/style.css".source = ../../../configs/apps/gtklock/style.css;
  xdg.configFile."xdg-desktop-portal/portals.conf".text = ''[preferred] default=gtk'';
  xdg.configFile."zellij/config.kdl".source = ../../../configs/apps/zellij/config.kdl;

  xdg.configFile."alacritty/alacritty.toml".source = ../../../configs/apps/alacritty/alacritty.toml;

  xdg.configFile."fcitx5/config".source = ../../../configs/apps/fcitx5/config;
  xdg.configFile."fcitx5/profile".source = ../../../configs/apps/fcitx5/profile;
  xdg.configFile."fcitx5/conf/punctuation.conf".source = ../../../configs/apps/fcitx5/conf/punctuation.conf;
  xdg.configFile."fcitx5/conf/spell.conf".source = ../../../configs/apps/fcitx5/conf/spell.conf;
  xdg.configFile."fcitx5/conf/keyboard.conf".source = ../../../configs/apps/fcitx5/conf/keyboard.conf;
  xdg.configFile."fcitx5/conf/notifications.conf".source = ../../../configs/apps/fcitx5/conf/notifications.conf;
  xdg.configFile."fcitx5/conf/chttrans.conf".source = ../../../configs/apps/fcitx5/conf/chttrans.conf;
}
