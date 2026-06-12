{ ... }: {
  imports = [
    ../services/adguardhome.nix
    ../services/dunst.nix
    ../services/fcitx5.nix
    ../services/flatpak.nix
    ../services/gnome-keyring.nix
    ../services/omnisearch.nix
    ../services/pipewire.nix
    ../services/sddm.nix
  ];
}
