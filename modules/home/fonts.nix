{ pkgs, ... }: {
  fonts = {
    packages = with pkgs; [
      nerd-fonts.fira-code
      nerd-fonts.jetbrains-mono
      nerd-fonts.hack
      nerd-fonts.symbols-only
      nerd-fonts.iosevka
      symbola
      dejavu_fonts
    ];
  };
}
