{ ... }: {
  programs.foot = {
    enable = true;
    settings = {
      main = {
        font = "Pragmasevka Nerd Font:size=11";
        term = "xterm-256color";
        dpi-aware = "yes";
        initial-window-size-pixels = "1000x600";
        pad = "10x10";
      };
      colors-dark = {
        background = "282a36";
        foreground = "f8f8f2";
        regular0 = "21222c";
        regular1 = "ff5555";
        regular2 = "50fa7b";
        regular3 = "f1fa8c";
        regular4 = "bd93f9";
        regular5 = "ff79c6";
        regular6 = "8be9fd";
        regular7 = "f8f8f2";
        bright0 = "6272a4";
        bright1 = "ff6e6e";
        bright2 = "69ff94";
        bright3 = "ffffa5";
        bright4 = "d6acff";
        bright5 = "ff92df";
        bright6 = "a4ffff";
        bright7 = "ffffff";
      };
      cursor = {
        style = "beam";
        blink = "yes";
      };
      scrollback.lines = 10000;
      mouse = {
        hide-when-typing = "yes";
      };
      search-bindings = {
        extend-char = "Control+Shift+l";
        extend-backward-char = "Control+Shift+h";
        extend-line-down = "Control+Shift+j";
        extend-line-up = "Control+Shift+k";
        extend-to-word-boundary = "Control+Shift+w";
        extend-backward-to-word-boundary = "Control+Shift+b";
      };
    };
  };
}
