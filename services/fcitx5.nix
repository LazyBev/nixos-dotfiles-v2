{ pkgs, ... }: {
  i18n.inputMethod = {
    type = "fcitx5";
    enable = true;
    fcitx5.addons = with pkgs; [
      qt6Packages.fcitx5-chinese-addons
      qt6Packages.fcitx5-configtool
      fcitx5-gtk
      qt6Packages.fcitx5-qt
      fcitx5-hangul
      fcitx5-mozc
      fcitx5-rime
      fcitx5-anthy
      catppuccin-fcitx5
      fcitx5-pinyin-moegirl
      fcitx5-pinyin-zhwiki
      fcitx5-pinyin-minecraft
    ];
  };
}
