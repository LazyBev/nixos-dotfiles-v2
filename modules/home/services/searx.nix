{ inputs, pkgs, ... }: {
  services.searx = {
    enable = true;
    settings.server = {
      secret_key = "bc23d878b750fc6087abf3161233a8dea21b0a3f9aed3a95d5cda75ffd35e3be";
      bind_address = "127.0.0.1";
      port = 8080;
    };
  };
}