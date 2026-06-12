{ ... }: {
  programs.vesktop = {
    enable = true;
    vencord.settings =
      (builtins.fromJSON (builtins.readFile ../configs/apps/vesktop/settings.json)).settings;
  };
}
