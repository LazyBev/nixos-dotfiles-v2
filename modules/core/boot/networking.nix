{ vars, ... }: {
  networking.hostName = vars.hostname;
  networking.networkmanager.enable = true;
  networking.networkmanager.wifi.powersave = false;
}
