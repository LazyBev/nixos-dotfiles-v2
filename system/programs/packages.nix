{inputs, pkgs, ...}: let
  vars2 = import ../../shared/vars.nix;
in {
  environment.systemPackages = with pkgs; [
    # terminal
    tree zathura imv

    # media
    poppler chafa ffmpegthumbnailer libnotify

    # browsing
    tor-browser

    # social
    gajim

    # dev
    delta opencode tinycc
    rust-stakeholder wl-clipboard
    pay-respects lazygit

    # virt
    qemu

    # games
    umu-launcher

    # vpn
    proton-vpn protonmail-desktop

    # themes
    catppuccin-sddm
    catppuccin-cursors.mochaMauve
    dracula-icon-theme
  ] ++ pkgs.lib.optional (vars2.systemTheme == "caelus") pkgs.caelus-theme
  ++ pkgs.lib.optional (vars2.systemTheme == "dracula") pkgs.dracula-theme
  ++ [
    (inputs.wrapper-modules.wrappers.noctalia-shell.wrap {
      inherit pkgs;
      settings =
        (builtins.fromJSON
          (builtins.readFile ../configs/apps/noctalia/noctalia.json)).settings;
    })
  ];
}
