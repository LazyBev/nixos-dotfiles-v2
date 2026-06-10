{
  self,
  inputs,
  ...
}: let
  vars = import ../../../vars.nix;
  mkGentuwu = extraModules:
    inputs.nixpkgs.lib.nixosSystem {
      specialArgs = {inherit inputs self vars;};
      modules =
        extraModules
        ++ [
          {nixpkgs.config.allowUnfree = true;}
          self.nixosModules.home
        ];
    };
in {
  flake.nixosConfigurations.gentuwu = mkGentuwu [
    self.nixosModules.common
    {gentuwu.hostType = "desktop";}
  ];
}
