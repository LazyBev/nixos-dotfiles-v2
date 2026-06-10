{...}: {
  imports = [../nixos/omnisearch.nix];
  services.omnisearch = {
    enable = true;
    settings.host = "127.0.0.1";
    settings.port = 8087;
  };
}
