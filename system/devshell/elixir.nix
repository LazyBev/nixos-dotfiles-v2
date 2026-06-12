{ ... }: {
  perSystem = { pkgs, ... }: {
    devShells.elixir = pkgs.mkShell {
      packages = with pkgs; [
        elixir
        erlang
        elixir-ls
        mix2nix
      ];
    };
  };
}
