{ config, lib, vars, ... }:
let
  cfg = config.gentuwu.docker;
in {
  options.gentuwu.docker = {
    enable = lib.mkOption {
      type = lib.types.bool;
      default = true;
      description = "Enable Docker daemon and related tools";
    };
    storageDriver = lib.mkOption {
      type = lib.types.str;
      default = "overlay2";
      description = "Docker storage driver to use";
    };
    daemonSettings = lib.mkOption {
      type = lib.types.attrs;
      default = {};
      description = "Extra settings for daemon.json";
    };
    enableNvidia = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Enable NVIDIA container toolkit support";
    };
  };

  config = lib.mkIf cfg.enable {
    virtualisation.docker = {
      enable = true;
      daemon.settings = {
        storage-driver = cfg.storageDriver;
        log-driver = "journald";
      } // cfg.daemonSettings;
    };

    hardware.nvidia-container-toolkit = lib.mkIf cfg.enableNvidia {
      enable = true;
    };
  };
}
