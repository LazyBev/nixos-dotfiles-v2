{ vars, pkgs, ... }: {
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

    sudo = { 
      enable = false;
    };

    pam = {
      services = { 
        doas = {};
        gtklock = {};
      };
    };
    rtkit.enable = true;
  };
} 
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };
  services.printing.enable = true;
  services.mpd = {
    enable = true;
    user = vars.username;
    settings = {
      music_directory = "/home/${vars.username}/Music";
      audio_output = [{
        type = "pipewire";
        name = "PipeWire Output";
      }];
    };
  };
