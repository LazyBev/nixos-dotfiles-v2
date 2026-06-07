{ inputs, pkgs, ... }: {
  services.xserver.enable = true;
  services.displayManager.sddm = {
    enable = true;
    theme = "catppuccin-mocha-mauve";
    settings = {
      Theme = {
        Font = "JetBrainsMono Nerd Font";
      };
      Cursor = {
        Theme = "catppuccin-mocha-mauve-cursors";
        Size = 24;
      };
    };
  };
}
