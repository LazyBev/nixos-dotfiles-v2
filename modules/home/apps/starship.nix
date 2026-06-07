{ ... }: {
  programs.starship = {
    enable = true;
    settings = {
      palette = "dracula";

      palettes.dracula = {
        background = "#282a36";
        current_line = "#44475a";
        foreground = "#f8f8f2";
        comment = "#6272a4";
        cyan = "#8be9fd";
        green = "#50fa7b";
        orange = "#ffb86c";
        pink = "#ff79c6";
        purple = "#bd93f9";
        red = "#ff5555";
        yellow = "#f1fa8c";
      };

      character = {
        success_symbol = "[λ](purple)";
        error_symbol = "[λ](red)";
      };

      directory.style = "bold cyan";

      git_branch = {
        style = "purple";
        format = "[$symbol$branch]($style)";
      };

      git_status.style = "red";

      nodejs.style = "green";
      rust.style = "red";
      python.style = "yellow";
    };
  };
}
