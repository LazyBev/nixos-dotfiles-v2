{ vars, ... }: {
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
}