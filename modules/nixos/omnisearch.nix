{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.services.omnisearch;

  finalConfigFile =
    if cfg.configFile != null
    then cfg.configFile
    else
      pkgs.writeText "omnisearch.ini" ''
        [server]
        host = ${cfg.settings.host}
        port = ${toString cfg.settings.port}
        domain = ${cfg.settings.domain}

        [cache]
        dir = ${cfg.settings.cacheDir}
        ttl_search = ${toString cfg.settings.ttlSearch}
        ttl_infobox = ${toString cfg.settings.ttlInfobox}
      '';
in {
  options.services.omnisearch = {
    enable = lib.mkEnableOption "omnisearch metasearch engine";

    package = lib.mkOption {
      type = lib.types.package;
      default = pkgs.omnisearch;
    };

    configFile = lib.mkOption {
      type = lib.types.nullOr lib.types.path;
      default = null;
    };

    settings = {
      host = lib.mkOption {
        type = lib.types.str;
        default = "127.0.0.1";
      };
      port = lib.mkOption {
        type = lib.types.port;
        default = 8087;
      };
      domain = lib.mkOption {
        type = lib.types.str;
        default = "http://localhost:8087";
      };
      cacheDir = lib.mkOption {
        type = lib.types.str;
        default = "/var/cache/omnisearch";
      };
      ttlSearch = lib.mkOption {
        type = lib.types.int;
        default = 3600;
      };
      ttlInfobox = lib.mkOption {
        type = lib.types.int;
        default = 86400;
      };
    };
  };

  config = lib.mkIf cfg.enable {
    systemd.services.omnisearch = {
      description = "omnisearch";
      after = ["network.target"];
      wantedBy = ["multi-user.target"];
      serviceConfig = {
        ExecStart = "${cfg.package}/bin/omnisearch";
        WorkingDirectory = "/var/lib/omnisearch";
        StateDirectory = "omnisearch";
        CacheDirectory = "omnisearch";
        BindReadOnlyPaths = [
          "${cfg.package}/share/omnisearch/templates:/var/lib/omnisearch/templates"
          "${cfg.package}/share/omnisearch/static:/var/lib/omnisearch/static"
          "${cfg.package}/share/omnisearch/locales:/var/lib/omnisearch/locales"
          "${finalConfigFile}:/var/lib/omnisearch/config.ini"
        ];
        DynamicUser = true;
        ProtectSystem = "strict";
        ProtectHome = true;
        PrivateTmp = true;
        Restart = "always";
      };
    };
  };
}
