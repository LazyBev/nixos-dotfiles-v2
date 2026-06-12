{ pkgs, vars, ... }: {
  users.users.root = {
    initialPassword = "changeme";
  };

  users.users.${vars.username} = {
    isNormalUser = true;
    initialPassword = "changeme";
    shell = pkgs.fish;
    description = vars.fullname;
    extraGroups = [ "networkmanager" "wheel" ];
  };
}
