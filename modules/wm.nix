{ self, pkgs, ... }: {
  imports = [
    ./wm/niri.nix
  ];

  programs.niri = {
    enable = true;
    package = self.packages.${pkgs.stdenv.hostPlatform.system}.niri-session;
  };
}
