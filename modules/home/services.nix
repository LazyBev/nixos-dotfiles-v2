{ self, inputs, pkgs, vars, ... }: {
  # ── Audio (PipeWire) ─────────────────────────────────────────────────────────
  services.pulseaudio.enable = false;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  # ── Dunst ────────────────────────────────────────────────────────────────────
  services.dunst = {
    enable = true;
    enableWayland = true;
  };

  # ── Fcitx5 ───────────────────────────────────────────────────────────────────
  i18n.inputMethod = {
    type = "fcitx5";
    enable = true;
    fcitx5.addons = with pkgs; [
      qt6Packages.fcitx5-chinese-addons
      qt6Packages.fcitx5-configtool
      fcitx5-gtk
      qt6Packages.fcitx5-qt
      fcitx5-hangul
      fcitx5-mozc
      fcitx5-rime
      fcitx5-anthy
      catppuccin-fcitx5
      fcitx5-pinyin-moegirl
      fcitx5-pinyin-zhwiki
      fcitx5-pinyin-minecraft
    ];
  };

  # ── Flatpak ──────────────────────────────────────────────────────────────────
  imports = [ inputs.nix-flatpak.nixosModules.nix-flatpak ];
  services.flatpak = {
    enable = true;
    remotes = [
      {
        name = "flathub";
        location = "https://flathub.org/repo/flathub.flatpakrepo";
      }
    ];
    packages = [
      "com.stremio.Stremio"
      "org.vinegarhq.Sober"
      "com.spotify.Client"
    ];
    overrides = {
      global = {
        Environment = {
          GTK_THEME = vars.theme;
        };
      };
    };
  };

  # ── MPD ──────────────────────────────────────────────────────────────────────
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

  # ── SDDM ─────────────────────────────────────────────────────────────────────
  services.xserver.enable = true;
  services.displayManager.defaultSession = "niri";
  services.displayManager.sddm = {
    enable = true;
    theme = "catppuccin-mocha-mauve";
    settings = {
      General = {
        AllowRootLogin = true;
      };
      Theme = {
        Font = vars.font;
      };
      Cursor = {
        Theme = vars.cursorTheme;
        Size = vars.cursorSize;
      };
    };
  };

  # ── AdGuard Home ─────────────────────────────────────────────────────────────
  services.adguardhome = {
    enable = true;
    mutableSettings = false;
    settings = {
      schema_version = 19;
      dns = {
        bind_host = "0.0.0.0";
        port = 53;
        upstream_dns = [
          "https://dns.cloudflare.com/dns-query"
          "https://dns.quad9.net/dns-query"
        ];
        bootstrap_dns = [ "1.1.1.1:53" "9.9.9.9:53" ];
        filtering_enabled = true;
        filters_update_interval = 48;
        edns_client_subnet = false;
        block_services = [];
        parental_enabled = false;
        safesearch_enabled = true;
        safebrowsing_enabled = true;
        querylog_interval = 720;
      };
      filtering = {
        filtering_enabled = true;
        filters = [
          {
            enabled = true;
            url = "https://adguardteam.github.io/AdGuardSDNSFilter/Filters/filter.txt";
            name = "AdGuard DNS filter";
          }
          {
            enabled = true;
            url = "https://raw.githubusercontent.com/StevenBlack/hosts/master/hosts";
            name = "StevenBlack's Unified Hosts";
          }
        ];
      };
      tls = {
        enabled = false;
      };
    };
  };

  networking.firewall = {
    enable = true;
    allowedUDPPorts = [ 53 ];
    allowedTCPPorts = [ 53 3000 ];
  };

  # ── Niri session ─────────────────────────────────────────────────────────────
  programs.niri = {
    enable = true;
    package = self.packages.${pkgs.stdenv.hostPlatform.system}.myNiri;
  };
}
