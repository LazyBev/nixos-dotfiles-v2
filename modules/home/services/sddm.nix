{ inputs, pkgs, vars, ... }: {
  services.xserver.enable = true;
  services.displayManager.sddm = {
    enable = true;
    theme = "catppuccin-mocha-mauve";
    settings = {
      General = {
        AllowRootLogin = true;
      };
      Theme = {
        Font = vars.font;
      };
      Cursor = {
        Theme = vars.cursorTheme;
        Size = vars.cursorSize;
      };
    };
  };
}
