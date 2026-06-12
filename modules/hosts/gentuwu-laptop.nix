{
  self,
  inputs,
  ...
}: let
  vars = import ../../vars.nix;
  mkGentuwuLaptop = extraModules:
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
  flake.nixosConfigurations.gentuwu-laptop = mkGentuwuLaptop [
    self.nixosModules.common
    {gentuwu.hostType = "laptop";}
  ];
}
