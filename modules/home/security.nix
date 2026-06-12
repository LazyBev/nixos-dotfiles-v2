{ vars, pkgs, lib, ... }: {
  security = {
    doas = {
      enable = true;
      extraRules = [{
        users = [ vars.username ];
        keepEnv = true;
        persist = true;
        noPass = false;
      }];
    };

    sudo = {
      enable = false;
    };

    apparmor = {
      enable = true;

      policies = {
        "qutebrowser" = {
          state = "enforce";
          profile = ''
            #include <tunables/global>
            profile qutebrowser /nix/store/*/bin/qutebrowser {
              #include <abstractions/base>
              #include <abstractions/nameservice>
              #include <abstractions/X>
              #include <abstractions/fonts>
              #include <abstractions/audio>
              #include <abstractions/dbus-session>
              #include <abstractions/user-tmp>

              /nix/store/*/bin/qutebrowser mr,
              /nix/store/*/lib/libQt* mr,
              /nix/store/*/lib/libwebengine* mr,

              owner @{HOME}/.config/qutebrowser/** rwk,
              owner @{HOME}/.local/share/qutebrowser/** rwk,
              owner @{HOME}/.cache/qutebrowser/** rwk,
              owner @{HOME}/Downloads/ rw,
              owner @{HOME}/Downloads/** rw,
              owner @{HOME}/Pictures/** r,
              owner @{HOME}/Music/** r,
              owner @{HOME}/Videos/** r,
              owner @{HOME}/Documents/** r,

              /etc/machine-id r,
            }
          '';
        };

        "dunst" = {
          state = "enforce";
          profile = ''
            #include <tunables/global>
            profile dunst /nix/store/*/bin/dunst {
              #include <abstractions/base>
              #include <abstractions/dbus-session>
              #include <abstractions/fonts>
              #include <abstractions/user-tmp>

              /nix/store/*/bin/dunst mr,
              owner @{HOME}/.config/dunst/** r,
              owner @{HOME}/.cache/dunst/** rwk,
              /run/user/*/wayland-* rw,
              /run/user/*/bus rw,
            }
          '';
        };

        "mpd" = {
          state = "enforce";
          profile = ''
            #include <tunables/global>
            profile mpd /nix/store/*/bin/mpd {
              #include <abstractions/base>
              #include <abstractions/nameservice>
              #include <abstractions/audio>
              #include <abstractions/dbus-session>

              /nix/store/*/bin/mpd mr,
              owner @{HOME}/.config/mpd/** rwk,
              owner @{HOME}/.local/share/mpd/** rwk,
              owner @{HOME}/Music/** r,
              /run/user/*/pipewire-* rw,
              /run/user/*/bus rw,
            }
          '';
        };
      };
    };

    pam = {
      services = {
        doas = {};
        gtklock = {};
      };
    };
    rtkit.enable = true;
  };
}
