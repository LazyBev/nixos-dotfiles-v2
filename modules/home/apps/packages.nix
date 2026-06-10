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
      links2
      browsh
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
      tor-browser
      steam
      gajim
      proton-vpn
      protonmail-desktop

      # dev
      tinycc
      opencode
      ollama
      ocamlPackages.ocaml
      ocamlPackages.dune_3
      ocamlPackages.findlib
      ocamlPackages.ocaml-lsp
      devenv
      opam
      wl-clipboard

      # virt
      qemu
      qemu_full

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
