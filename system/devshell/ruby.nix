{ ... }: {
  perSystem = { pkgs, ... }: {
    devShells.ruby = pkgs.mkShell {
      packages = with pkgs; [
        ruby
        rubyPackages.solargraph
        rubyPackages.rubocop
        bundler
      ];
    };
  };
}
