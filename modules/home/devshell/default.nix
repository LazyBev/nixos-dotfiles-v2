{ ... }: {
  perSystem = { pkgs, ... }: {
    devShells.default = pkgs.mkShell {
      packages = with pkgs; [
        alejandra
        nil
        statix
        nix-output-monitor
        nix-init
        nurl
        nh
      ];
    };

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

    devShells.go = pkgs.mkShell {
      packages = with pkgs; [
        go
        gopls
        gotools
        go-tools
        delve
      ];
    };

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

    devShells.node = pkgs.mkShell {
      packages = with pkgs; [
        nodejs
        typescript
        nodePackages.typescript-language-server
        nodePackages.prettier
        nodePackages.eslint
        nodePackages.tailwindcss
        yarn
        pnpm
      ];
    };

    devShells.java = pkgs.mkShell {
      packages = with pkgs; [
        jdk
        gradle
        maven
        jdt-language-server
      ];
    };

    devShells.zig = pkgs.mkShell {
      packages = with pkgs; [
        zig
        zls
      ];
    };

    devShells.lua = pkgs.mkShell {
      packages = with pkgs; [
        lua
        luajit
        luarocks
        lua-language-server
      ];
    };

    devShells.haskell = pkgs.mkShell {
      packages = with pkgs; [
        ghc
        cabal-install
        stack
        haskell-language-server
        hlint
      ];
    };

    devShells.elixir = pkgs.mkShell {
      packages = with pkgs; [
        elixir
        erlang
        elixir-ls
        mix2nix
      ];
    };

    devShells.ruby = pkgs.mkShell {
      packages = with pkgs; [
        ruby
        rubyPackages.solargraph
        rubyPackages.rubocop
        bundler
      ];
    };

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

    devShells.orix-dev = pkgs.mkShell {
      packages = with pkgs; [
        ocaml
        ocamlPackages.findlib
        gcc
        gnumake
        curl
        cpio
        gzip
        grub2
        libisoburn
        file
        patchelf
        flex
        bison
        bc
        libxcrypt
        qemu
        parted
        e2fsprogs
        util-linux
        openssl
      ];
    };
  };
}
