{ ... }: {
  perSystem = { pkgs, ... }: {
    devShells.c = pkgs.mkShell {
      packages = with pkgs; [
        gcc
        clang
        gnumake
        cmake
        meson
        ninja
        bear
        pkg-config
        ccls
        gdb
        valgrind
      ];
    };
  };
}
