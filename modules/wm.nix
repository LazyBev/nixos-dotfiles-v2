{ self, pkgs, ... }: {
  imports = [
    ./wm/dwl.nix
    ./wm/niri.nix
  ];

  programs.niri = {
    enable = true;
    package = self.packages.${pkgs.stdenv.hostPlatform.system}.niri-session;
  };

  programs.dwl = {
    enable = true;
    package = self.packages.${pkgs.stdenv.hostPlatform.system}.dwl-session;
  };
}
