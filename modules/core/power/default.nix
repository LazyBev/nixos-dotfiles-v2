{ config, lib, pkgs, ... }: let
  cfg = config.gentuwu.powerProfiles;
  scxPkg = pkgs.scx.full;

  profileScript = pkgs.writeShellScriptBin "power-profile" ''
    case "''${1:-status}" in
      performance)
        systemctl start scx-bpfland 2>/dev/null || true
        for cpu in /sys/devices/system/cpu/cpu*/cpufreq/scaling_governor; do
          echo performance > "$cpu" 2>/dev/null || true
        done
        echo 0  > /proc/sys/vm/swappiness 2>/dev/null || true
        echo 10 > /proc/sys/vm/vfs_cache_pressure 2>/dev/null || true
        echo 40 > /proc/sys/vm/dirty_ratio 2>/dev/null || true
        echo 15 > /proc/sys/vm/dirty_background_ratio 2>/dev/null || true
        for dev in /sys/class/net/*/device/power/control; do
          echo on > "$dev" 2>/dev/null || true
        done
        echo "→ performance (SCX bpfland)"
        ;;
      battery)
        systemctl stop scx-bpfland 2>/dev/null || true
        for cpu in /sys/devices/system/cpu/cpu*/cpufreq/scaling_governor; do
          echo powersave > "$cpu" 2>/dev/null || true
        done
        echo 100 > /proc/sys/vm/swappiness 2>/dev/null || true
        echo 250 > /proc/sys/vm/vfs_cache_pressure 2>/dev/null || true
        echo 10  > /proc/sys/vm/dirty_ratio 2>/dev/null || true
        echo 5   > /proc/sys/vm/dirty_background_ratio 2>/dev/null || true
        for dev in /sys/class/net/*/device/power/control; do
          echo auto > "$dev" 2>/dev/null || true
        done
        echo "→ battery (BORE default scheduler)"
        ;;
      status)
        echo "scheduler:     $(systemctl is-active scx-bpfland 2>/dev/null | sed 's/inactive/BORE (EEVDF)/;s/active/SCX bpfland/')"
        echo "governor:      $(cat /sys/devices/system/cpu/cpu0/cpufreq/scaling_governor 2>/dev/null || echo N/A)"
        echo "swappiness:    $(cat /proc/sys/vm/swappiness 2>/dev/null || echo N/A)"
        echo "cache_pressure:$(cat /proc/sys/vm/vfs_cache_pressure 2>/dev/null || echo N/A)"
        echo "dirty_ratio:   $(cat /proc/sys/vm/dirty_ratio 2>/dev/null || echo N/A)"
        echo "dirty_bg_ratio:$(cat /proc/sys/vm/dirty_background_ratio 2>/dev/null || echo N/A)"
        ;;
      *)
        echo "Usage: power-profile {performance|battery|status}" >&2
        exit 1
        ;;
    esac
  '';
in {
  options.gentuwu.powerProfiles = {
    enable = lib.mkEnableOption "power profile switching";
    default = lib.mkOption {
      type = lib.types.enum [ "performance" "battery" ];
      default = "performance";
    };
  };

  config = lib.mkIf cfg.enable {
    environment.systemPackages = [ profileScript scxPkg ];

    boot.kernel.sysctl = {
      "vm.swappiness" = lib.mkOverride 50 (if cfg.default == "performance" then 0 else 100);
      "vm.vfs_cache_pressure" = lib.mkOverride 50 (if cfg.default == "performance" then 10 else 250);
      "vm.dirty_ratio" = lib.mkOverride 50 (if cfg.default == "performance" then 40 else 10);
      "vm.dirty_background_ratio" = lib.mkOverride 50 (if cfg.default == "performance" then 15 else 5);
    };

    systemd.services.scx-bpfland = {
      description = "SCX BPFLand scheduler (performance)";
      serviceConfig = {
        Type = "simple";
        ExecStart = "${scxPkg}/bin/scx_bpfland";
      };
    };

    systemd.services.power-profile = {
      description = "Apply ${cfg.default} power profile";
      wantedBy = [ "multi-user.target" ];
      after = [ "sysinit.target" ];
      serviceConfig = {
        Type = "oneshot";
        ExecStart = "${profileScript}/bin/power-profile ${cfg.default}";
      };
    };
  };
}
