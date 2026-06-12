{ ... }: {
  perSystem = { pkgs, ... }: {
    devShells.haskell = pkgs.mkShell {
      packages = with pkgs; [
        ghc
        cabal-install
        stack
        haskell-language-server
        hlint
      ];
    };
  };
}
