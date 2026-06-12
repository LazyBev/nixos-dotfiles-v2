{ ... }: {
  perSystem = { pkgs, ... }: {
    devShells.lua = pkgs.mkShell {
      packages = with pkgs; [
        lua
        luajit
        luarocks
        lua-language-server
      ];
    };
  };
}
