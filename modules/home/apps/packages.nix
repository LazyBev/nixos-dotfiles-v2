{ pkgs, inputs, ... }: {
  environment.systemPackages = with pkgs; [
    # tui
    btop delta yazi tree
    kitty
    zathura imv mpv
    rmpc cava
    zellij lazygit links2 browsh
    gh pay-respects

    # gui
    fuzzel searxng
    vscodium
    thunar thunar-archive-plugin thunar-volman tumbler
    networkmanagerapplet
    gtklock
    qutebrowser
    tor-browser
    steam
    proton-vpn protonmail-desktop

    # dev
    tinycc
    opencode
    ollama
    ocamlPackages.ocaml ocamlPackages.dune_3
    ocamlPackages.findlib ocamlPackages.ocaml-lsp
    devenv opam

    # virt
    qemu qemu_full

    # media
    poppler chafa ffmpegthumbnailer
    libnotify

    # themes
    catppuccin-sddm catppuccin-cursors.mochaMauve
    dracula-theme dracula-icon-theme
  ] ++ [
    (inputs.wrapper-modules.wrappers.noctalia-shell.wrap {
      inherit pkgs;
      settings =
        (builtins.fromJSON
          (builtins.readFile ../../../configs/apps/noctalia/noctalia.json)).settings;
    })
  ];
}
