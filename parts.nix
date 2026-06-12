{ inputs, self, ... }: {
  config = {
    systems = [ "x86_64-linux" "aarch64-linux" ];
    perSystem = { system, ... }: {
      _module.args.pkgs = import inputs.nixpkgs {
        inherit system;
        config.allowUnfree = true;
        overlays = [
          (final: prev: {
            dwl = (prev.dwl.override {
              enableXWayland = true;
              configH = ./configs/apps/dwl/config.h;
            }).overrideAttrs (old: {
              patches = (old.patches or []) ++ [
                ./configs/apps/dwl/patches/vanitygaps.patch
                ./configs/apps/dwl/patches/pertag.patch
                ./configs/apps/dwl/patches/attachbottom.patch
                ./configs/apps/dwl/patches/movestack.patch
                ./configs/apps/dwl/patches/dragmfact.patch
                ./configs/apps/dwl/patches/shiftview.patch
                ./configs/apps/dwl/patches/sticky.patch
              ];
            });
          })
        ];
      };
    };
  };
}
