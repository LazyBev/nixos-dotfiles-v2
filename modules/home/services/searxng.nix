{ inputs, pkgs, ... }: {
  services.searxng = {
    enable = true;
    settings = {
      server.secret_key = "changeme";
      server.bind_address = "127.0.0.1";
      server.port = 8080;
    };
  };
}