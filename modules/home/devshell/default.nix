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
