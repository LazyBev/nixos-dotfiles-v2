{ pkgs, vars, ... }: {
  users.users.${vars.username} = {
    isNormalUser = true;
    shell = pkgs.fish;
    description = vars.fullname;
    extraGroups = [ "networkmanager" "wheel" "docker" ];
  };
}
