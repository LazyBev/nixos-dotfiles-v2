{ inputs, pkgs, ... }: {
  services.dunst = {
    enable = true;
    enableWayland = true;
  };
}

