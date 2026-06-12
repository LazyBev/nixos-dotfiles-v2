let
  # available themes: "dracula", "caelus"
  systemTheme = "dracula";

  presets = {
    dracula = {
      theme = "Dracula";
      cursorTheme = "catppuccin-mocha-mauve-cursors";
      cursorSize = 24;
      font = "Pragmasevka Nerd Font";
      terminal = "alacritty";
      qtTheme = "adwaita-dark";
    };
    caelus = {
      theme = "caelus-custom";
      cursorTheme = "catppuccin-mocha-mauve-cursors";
      cursorSize = 24;
      font = "Pragmasevka Nerd Font";
      terminal = "alacritty";
      qtTheme = "adwaita-dark";
    };
  };

  selected = presets.${systemTheme};
in
  selected // {
    inherit systemTheme presets;

    username = "yari";
    fullname = "yari";
    email = "lazy25yari@proton.me";
    hostname = "gentuwu";
    maxJobs = 4;

    stateVersion = "26.05";
    keyboardLayout = "gb";
    platform = "x86_64-linux";

    repoDir = "~/nixos-cfg";
  }
