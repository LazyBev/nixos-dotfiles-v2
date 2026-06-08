{ inputs, pkgs, ... }: {
  services.xserver.enable = true;
  services.displayManager.sddm = {
    enable = true;
    theme = "catppuccin-mocha-mauve";
    settings = {
      Theme = {
        Font = "Pragmasevka Nerd Font";
      };
      Cursor = {
        Theme = "catppuccin-mocha-mauve-cursors";
        Size = 24;
      };
    };
  };
}
