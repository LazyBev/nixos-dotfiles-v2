let
  vars = import ../../../vars.nix;
in {
  pkgs,
  inputs,
  ...
}: {
  environment.systemPackages = with pkgs;
    [
      # tui
      alacritty
      btop
      delta
      yazi
      tree
      kitty
      zathura
      imv
      mpv
      rmpc
      cava
      zellij
      lazygit
      gh
      pay-respects

      # gui
      fuzzel
      vscodium
      thunar
      thunar-archive-plugin
      thunar-volman
      tumbler
      networkmanagerapplet
      gtklock
      qutebrowser
      steam
      tor-browser
      gajim
      proton-vpn
      protonmail-desktop

      # dev
      tinycc
      opencode
      rust-stakeholder
      wl-clipboard

      # virt
      qemu

      # media
      poppler
      chafa
      ffmpegthumbnailer
      libnotify

      # themes
      catppuccin-sddm
      catppuccin-cursors.mochaMauve
      dracula-icon-theme
    ]
    ++ (pkgs.lib.optional (vars.systemTheme == "dracula") pkgs.dracula-theme)
    ++ (pkgs.lib.optional (vars.systemTheme == "caelus") pkgs.caelus-theme)
    ++ [
      (inputs.wrapper-modules.wrappers.noctalia-shell.wrap {
        inherit pkgs;
        settings =
          (builtins.fromJSON
            (builtins.readFile ../../../configs/apps/noctalia/noctalia.json)).settings;
      })
    ];
}
