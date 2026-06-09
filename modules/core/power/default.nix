{ config, lib, pkgs, ... }: let
  cfg = config.gentuwu.powerProfiles;
  scxPkg = pkgs.scx.full;

  applyScript = pkgs.writeShellScript "power-profile-apply" ''
    set -eu

    set_governor() {
      for cpu in /sys/devices/system/cpu/cpu*/cpufreq/scaling_governor; do
        echo "$1" > "$cpu" 2>/dev/null || true
      done
    }

    set_cpu_max_freq() {
      for cpu in /sys/devices/system/cpu/cpu*/cpufreq; do
        [ -f "$cpu/scaling_max_freq" ] || continue
        if [ "$1" = "max" ]; then
          cat "$cpu/cpuinfo_max_freq" > "$cpu/scaling_max_freq" 2>/dev/null || true
        else
          echo "$1" > "$cpu/scaling_max_freq" 2>/dev/null || true
        fi
      done
    }

    for_each_net() {
      for dev in /sys/class/net/*/device/power/control; do
        echo "$1" > "$dev" 2>/dev/null || true
      done
    }

    for_each_pci() {
      for dev in /sys/bus/pci/devices/*/power/control; do
        echo "$1" > "$dev" 2>/dev/null || true
      done
    }

    for_each_sata() {
      for host in /sys/class/scsi_host/host*/link_power_management_policy; do
        echo "$1" > "$host" 2>/dev/null || true
      done
    }

    case "''${1:-}" in
      performance)
        systemctl start scx-bpfland 2>/dev/null || true
        set_governor performance
        set_cpu_max_freq max

        echo 0   > /proc/sys/vm/swappiness 2>/dev/null || true
        echo 10  > /proc/sys/vm/vfs_cache_pressure 2>/dev/null || true
        echo 40  > /proc/sys/vm/dirty_ratio 2>/dev/null || true
        echo 15  > /proc/sys/vm/dirty_background_ratio 2>/dev/null || true

        for_each_net on
        for_each_pci on

        echo 0 > /sys/module/snd_hda_intel/parameters/power_save 2>/dev/null || true
        echo performance > /sys/module/pcie_aspm/parameters/policy 2>/dev/null || true

        echo 100 > /sys/devices/system/cpu/intel_pstate/max_perf_pct 2>/dev/null || true
        echo 100 > /sys/devices/system/cpu/intel_pstate/min_perf_pct 2>/dev/null || true
        echo 100 > /sys/devices/system/cpu/amd_pstate/max_perf_pct 2>/dev/null || true
        echo 100 > /sys/devices/system/cpu/amd_pstate/min_perf_pct 2>/dev/null || true

        echo high > /sys/class/drm/card0/device/power_dpm_force_performance_level 2>/dev/null || true
        echo 0 > /sys/class/drm/card0/power_dc 2>/dev/null || true
        cat /sys/class/drm/card1/gt_RP1_freq_mhz > /sys/class/drm/card1/gt_max_freq_mhz 2>/dev/null || true
        ;;
      balanced)
        systemctl stop scx-bpfland 2>/dev/null || true
        set_governor schedutil
        set_cpu_max_freq max

        echo 60  > /proc/sys/vm/swappiness 2>/dev/null || true
        echo 100 > /proc/sys/vm/vfs_cache_pressure 2>/dev/null || true
        echo 20  > /proc/sys/vm/dirty_ratio 2>/dev/null || true
        echo 10  > /proc/sys/vm/dirty_background_ratio 2>/dev/null || true

        for_each_net on
        for_each_pci auto

        echo 1 > /sys/module/snd_hda_intel/parameters/power_save 2>/dev/null || true
        echo default > /sys/module/pcie_aspm/parameters/policy 2>/dev/null || true

        echo 80 > /sys/devices/system/cpu/intel_pstate/max_perf_pct 2>/dev/null || true
        echo 20 > /sys/devices/system/cpu/intel_pstate/min_perf_pct 2>/dev/null || true
        echo 80 > /sys/devices/system/cpu/amd_pstate/max_perf_pct 2>/dev/null || true
        echo 20 > /sys/devices/system/cpu/amd_pstate/min_perf_pct 2>/dev/null || true

        echo auto > /sys/class/drm/card0/device/power_dpm_force_performance_level 2>/dev/null || true
        for_each_sata med_power_with_dipm
        ;;
      battery)
        systemctl stop scx-bpfland 2>/dev/null || true
        set_governor powersave

        for cpu_freq in /sys/devices/system/cpu/cpu*/cpufreq; do
          max=$(cat "$cpu_freq/cpuinfo_max_freq" 2>/dev/null || echo 0)
          [ "$max" -gt 0 ] 2>/dev/null && echo $((max * 40 / 100)) > "$cpu_freq/scaling_max_freq" 2>/dev/null || true
        done

        echo 100 > /proc/sys/vm/swappiness 2>/dev/null || true
        echo 250 > /proc/sys/vm/vfs_cache_pressure 2>/dev/null || true
        echo 10  > /proc/sys/vm/dirty_ratio 2>/dev/null || true
        echo 5   > /proc/sys/vm/dirty_background_ratio 2>/dev/null || true

        for_each_net auto
        for_each_pci auto

        echo 10 > /sys/module/snd_hda_intel/parameters/power_save 2>/dev/null || true
        echo powersave > /sys/module/pcie_aspm/parameters/policy 2>/dev/null || true

        echo 40 > /sys/devices/system/cpu/intel_pstate/max_perf_pct 2>/dev/null || true
        echo 10 > /sys/devices/system/cpu/intel_pstate/min_perf_pct 2>/dev/null || true
        echo 40 > /sys/devices/system/cpu/amd_pstate/max_perf_pct 2>/dev/null || true
        echo 10 > /sys/devices/system/cpu/amd_pstate/min_perf_pct 2>/dev/null || true

        for_each_sata min_power
        echo 1000 > /sys/module/usbcore/parameters/autosuspend 2>/dev/null || true

        echo low > /sys/class/drm/card0/device/power_dpm_force_performance_level 2>/dev/null || true
        echo 1 > /sys/class/drm/card0/power_dc 2>/dev/null || true
        echo 200 > /sys/class/drm/card1/gt_max_freq_mhz 2>/dev/null || true
        ;;
    esac
  '';

  cliScript = pkgs.writeShellScriptBin "power-profile" ''
    case "''${1:-status}" in
      performance|balanced|battery)
        systemctl start "power-profile@''${1}.service"
        echo "→ switched to ''${1}"
        ;;
      status)
        printf "%-18s %s\n" "scheduler:"       "$(systemctl is-active scx-bpfland 2>/dev/null | sed 's/inactive/BORE (EEVDF)/;s/active/SCX bpfland/')"
        printf "%-18s %s\n" "governor:"         "$(cat /sys/devices/system/cpu/cpu0/cpufreq/scaling_governor 2>/dev/null || echo N/A)"
        printf "%-18s %s\n" "max freq:"         "$(cat /sys/devices/system/cpu/cpu0/cpufreq/scaling_max_freq 2>/dev/null || echo N/A)"
        printf "%-18s %s\n" "swappiness:"       "$(cat /proc/sys/vm/swappiness 2>/dev/null || echo N/A)"
        printf "%-18s %s\n" "cache_pressure:"   "$(cat /proc/sys/vm/vfs_cache_pressure 2>/dev/null || echo N/A)"
        printf "%-18s %s\n" "dirty_ratio:"      "$(cat /proc/sys/vm/dirty_ratio 2>/dev/null || echo N/A)"
        printf "%-18s %s\n" "dirty_bg_ratio:"   "$(cat /proc/sys/vm/dirty_background_ratio 2>/dev/null || echo N/A)"
        printf "%-18s %s\n" "audio_power_save:" "$(cat /sys/module/snd_hda_intel/parameters/power_save 2>/dev/null || echo N/A)"
        printf "%-18s %s\n" "pcie_aspm:"        "$(cat /sys/module/pcie_aspm/parameters/policy 2>/dev/null || echo N/A)"
        printf "%-18s %s\n" "sata_lpm:"         "$(cat /sys/class/scsi_host/host0/link_power_management_policy 2>/dev/null || echo N/A)"
        ;;
      *)
        echo "Usage: power-profile {performance|balanced|battery|status|help}" >&2
        exit 1
        ;;
    esac
  '';
in {
  options.gentuwu.powerProfiles = {
    enable = lib.mkEnableOption "power profile switching";
    default = lib.mkOption {
      type = lib.types.enum [ "performance" "balanced" "battery" ];
      default = "performance";
    };
  };

  config = lib.mkIf cfg.enable {
    environment.systemPackages = [ cliScript scxPkg ];

    boot.kernel.sysctl = {
      "vm.swappiness" = lib.mkOverride 50 (
        if cfg.default == "performance" then 0
        else if cfg.default == "balanced" then 60
        else 100
      );
      "vm.vfs_cache_pressure" = lib.mkOverride 50 (
        if cfg.default == "performance" then 10
        else if cfg.default == "balanced" then 100
        else 250
      );
      "vm.dirty_ratio" = lib.mkOverride 50 (
        if cfg.default == "performance" then 40
        else if cfg.default == "balanced" then 20
        else 10
      );
      "vm.dirty_background_ratio" = lib.mkOverride 50 (
        if cfg.default == "performance" then 15
        else if cfg.default == "balanced" then 10
        else 5
      );
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
        ExecStart = "${applyScript} ${cfg.default}";
      };
    };

    systemd.services."power-profile@" = {
      description = "Apply power profile %I";
      serviceConfig = {
        Type = "oneshot";
        ExecStart = "${applyScript} %I";
      };
    };
  };
}
