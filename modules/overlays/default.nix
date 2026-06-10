{inputs, ...}: {
  flake.nixosModules.overlays = {...}: {
    nixpkgs.overlays = [
      (import ./omnisearch.nix {inherit inputs;})
    ];
  };
}
