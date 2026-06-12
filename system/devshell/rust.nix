{ ... }: {
  perSystem = { pkgs, ... }: {
    devShells.rust = pkgs.mkShell {
      packages = with pkgs; [
        rustc
        cargo
        rust-analyzer
        clippy
        rustfmt
        rustPackages.rustPlatform.rustLibSrc
      ];
    };
  };
}
