{ inputs, pkgs, ... }: {
  services.searx = {
    enable = true;
    settings = {
      server.secret_key = "idk";
      server.bind_address = "127.0.0.1";
      server.port = 8080;
    };
  };
}