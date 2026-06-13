{ vars, ... }: {
  security = {
    doas = {
      enable = true;
      extraRules = [{
        users = [ vars.username ];
        keepEnv = true;
        persist = true;
        noPass = false;
      }];
    };
    sudo.enable = false;
    apparmor.enable = false;
    pam.services = {
      doas = {};
      gtklock = {};
    };
    rtkit.enable = true;
  };
}
