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
      key-bindings = {
        select-begin = "Control+Space";
        select-begin-block = "Control+Shift+Space";
        select-extend-character-wise = "Right";
        select-extend-line-wise = "Down";
        select-extend-to-previous-line = "Up";
        select-extend-to-previous-word = "Control+Left";
        select-extend-to-next-word = "Control+Right";
        select-extend-to-start-of-line = "Home";
        select-extend-to-end-of-line = "End";
        clipboard-copy = "Control+Shift+c";
      };
    };
  };
}
