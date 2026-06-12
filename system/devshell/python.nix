{ ... }: {
  perSystem = { pkgs, ... }: {
    devShells.python = pkgs.mkShell {
      packages = with pkgs; [
        python3
        python3Packages.pip
        python3Packages.virtualenv
        python3Packages.python-lsp-server
        python3Packages.black
        python3Packages.ruff
        python3Packages.mypy
        python3Packages.pytest
        python3Packages.ipython
      ];
    };
  };
}
