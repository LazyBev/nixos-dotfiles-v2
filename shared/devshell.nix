{ ... }: {
  imports = [
    ../system/devshell/default-devshell.nix
    ../system/devshell/rust.nix
    ../system/devshell/go.nix
    ../system/devshell/python.nix
    ../system/devshell/java.nix
    ../system/devshell/zig.nix
    ../system/devshell/lua.nix
    ../system/devshell/haskell.nix
    ../system/devshell/elixir.nix
    ../system/devshell/ruby.nix
    ../system/devshell/c.nix
    ../system/devshell/orix-dev.nix
  ];
}
