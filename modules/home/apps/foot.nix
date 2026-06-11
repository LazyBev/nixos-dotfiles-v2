{ pkgs, ... }: {
  programs.foot = {
    enable = true;
    package = pkgs.foot;
  };
}
