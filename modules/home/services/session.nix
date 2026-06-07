{ self, pkgs, ... }: {
  programs.niri = {
    enable = true;
    package = self.packages.${pkgs.stdenv.hostPlatform.system}.myNiri;
  };
}
