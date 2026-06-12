let
  vars = import ../../../vars.nix;
in {
  pkgs,
  inputs,
  ...
}: {
  environment.systemPackages = with pkgs;
    [
      # terminal
      alacritty
      zellij
      btop
      cava
      lazygit
      yazi
      tree
      zathura
      imv

      # media
      mpv
      rmpc
      poppler
      chafa
      ffmpegthumbnailer
      libnotify

      # gui
      fuzzel
      gtklock
      networkmanagerapplet
      thunar
      thunar-archive-plugin
      thunar-volman
      tumbler
      waypaper

      # browsing
      qutebrowser
      tor-browser

      # social
      gajim

      # dev
      delta
      opencode
      tinycc
      rust-stakeholder
      vscodium
      wl-clipboard
      pay-respects

      # virt
      qemu

      # games
      steam
      umu-launcher

      # vpn
      proton-vpn
      protonmail-desktop

      # themes
      catppuccin-sddm
      catppuccin-cursors.mochaMauve
      dracula-icon-theme
    ]
    ++ pkgs.lib.optional (vars.systemTheme == "caelus") pkgs.caelus-theme
    ++ pkgs.lib.optional (vars.systemTheme == "dracula") pkgs.dracula-theme
    ++ [
      (inputs.wrapper-modules.wrappers.noctalia-shell.wrap {
        inherit pkgs;
        settings =
          (builtins.fromJSON
            (builtins.readFile ../../../configs/apps/noctalia/noctalia.json)).settings;
      })
    ];
}
