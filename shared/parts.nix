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
              configH = ../system/configs/apps/dwl/config.h;
            }).overrideAttrs (old: {
              patches = (old.patches or []) ++ [
                ../system/configs/apps/dwl/patches/vanitygaps.patch
                ../system/configs/apps/dwl/patches/pertag.patch
                ../system/configs/apps/dwl/patches/attachbottom.patch
                ../system/configs/apps/dwl/patches/movestack.patch
                ../system/configs/apps/dwl/patches/dragmfact.patch
                ../system/configs/apps/dwl/patches/shiftview.patch
                ../system/configs/apps/dwl/patches/sticky.patch
              ];
            });
          })
        ];
      };
    };
  };
}
