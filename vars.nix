let
  # available themes: "dracula", "caelus"
  systemTheme = "dracula";

  presets = {
    dracula = {
      theme = "Dracula";
      cursorTheme = "catppuccin-mocha-mauve-cursors";
      cursorSize = 24;
      font = "Pragmasevka Nerd Font";
      terminal = "foot";
      qtTheme = "adwaita-dark";
    };
    caelus = {
      theme = "caelus-custom";
      cursorTheme = "catppuccin-mocha-mauve-cursors";
      cursorSize = 24;
      font = "Pragmasevka Nerd Font";
      terminal = "foot";
      qtTheme = "adwaita-dark";
    };
  };

  selected = presets.${systemTheme};
in
  selected // {
    inherit systemTheme presets;

    username = "yari";
    fullname = "yari";
    email = "yari@yari.xyz";
    hostname = "gentuwu";
    maxJobs = 6;

    stateVersion = "26.05";
    keyboardLayout = "gb";
    platform = "x86_64-linux";

    repoDir = "~/nixos-cfg";
  }
