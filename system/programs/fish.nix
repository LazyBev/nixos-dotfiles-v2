{
  inputs,
  pkgs,
  vars,
  ...
}: {
  programs.fish = {
    enable = true;

    shellAliases = {
      clone-nixos = "git clone https://github.com/LazyBev/nixos-cfg ${vars.repoDir}";
      EDITOR = "nvim";
      VISUAL = "nvim";
      ls = "eza";
      ll = "eza -l";
      la = "eza -la";
      lt = "eza -l --tree";
      battery = "echo \"$(cat /sys/class/power_supply/BAT1/capacity)%\"";
      ncUpd = "noctalia-shell ipc call state all > ${vars.repoDir}/configs/apps/noctalia/noctalia.json";

      gen-list = "doas nixos-rebuild list-generations";
      gif = "ffmpeg -vf \"fps=10,scale=720:-1:flags=lanczos,split[s0][s1];[s0]palettegen=max_colors=256[p];[s1][p]paletteuse=dither=bayer\"";
      gifslow = "ffmpeg -vf \"fps=5,scale=720:-1:flags=lanczos,split[s0][s1];[s0]palettegen=max_colors=256[p];[s1][p]paletteuse=dither=bayer\"";
      "rec" = "ffmpeg -f x11grab -video_size 1920x1080 -framerate 30 -i :0.0 -c:v libx264 -preset ultrafast -pix_fmt yuv420p";
      reca = "ffmpeg -f pulse -i default -c:a libmp3lame -q:a 2";
      get_audio = "ffmpeg -vn -c:a libmp3lame -q:a 2";
      screenshot = "ffmpeg -f x11grab -video_size 1920x1080 -framerate 1 -i :0.0 -vframes 1";
      h264 = "ffmpeg -c:v libx264 -crf 23 -c:a aac";
      h265 = "ffmpeg -c:v libx265 -crf 28 -c:a aac -b:a 128k";
      vp9 = "ffmpeg -c:v libvpx-vp9 -crf 30 -b:v 0 -c:a libopus";
      av1 = "ffmpeg -c:v libsvtav1 -crf 35 -preset 8 -c:a libopus";
      prores = "ffmpeg -c:v prores_ks -profile:v 3 -vendor apl0 -c:a pcm_s16le";
      define = "curl -s \"dict://dict.org/d:\"";
      ptndwrk = "rust-stakeholder -d fullstack -j extreme -c extreme -a -t";
    };

    shellAbbrs = {
      n = "nix";
      nf = "nix flake";
      ns = "nix search";
      ne = "nix-env";
    };

    interactiveShellInit = ''
      set fish_greeting

      if set -q WAYLAND_DISPLAY && not set -q DISPLAY
        set -x DISPLAY :1
      end

      function gp
        git add .
        git commit -m "$argv"
        git push
      end

      function upgrade
        doas nixos-rebuild switch --flake ".#$argv" -j(math (nproc) / 2)
      end

      function sysupd
        nix flake update && doas nixos-rebuild switch --flake ".#$argv" -j(math (nproc) / 2)
      end

      function install
        wipefs -a /dev/nvme0n1 && sgdisk --zap-all /dev/nvme0n1 && partprobe /dev/nvme0n1 && sleep 2 && wipefs -a /dev/nvme0n1p* 2>/dev/null; nix --experimental-features "nix-command flakes" run github:nix-community/disko -- --mode disko --flake ".#$argv" && nixos-install --root /mnt --max-jobs 1 --flake ".#$argv"
      end

      function search
        nix search nixpkgs $argv
      end

      function search-options
        nix-instantiate --eval -E "(import <nixpkgs/nixos> {}).options" | grep -i $argv
      end

      function check
        nix flake check $argv
      end

      function flakeupd
        nix flake update $argv
      end

      function gc
        doas nix-collect-garbage --delete-older-than 30d $argv
      end

      function lint
        nix flake check $argv
      end

      function clean
        doas nix-collect-garbage -d; nix-collect-garbage -d
      end

      function devenv-shell
        devenv shell $argv
      end

      function devenv-test
        devenv test $argv
      end

      function devenv-update
        devenv update $argv
      end

      function devenv-gc
        devenv gc $argv
      end

      function gitwho
        git config --global user.name "$argv[1]"
        git config --global user.email "$argv[2]"
      end

      function __fish_h_item; echo $history[1]; end
      function __fish_h_arg;  string split " " -- $history[1] | tail -1; end
      function __fish_h_all;  string split " " -- $history[1] | tail -n +2 | string join " "; end
      function __fish_h_first; string split " " -- $history[1] | awk '{print $2}'; end
      function __fish_h_cmd;  string split " " -- $history[1] | head -1; end

      abbr -a !!   --position anywhere --function __fish_h_item
      abbr -a '!$' --position anywhere --function __fish_h_arg
      abbr -a '!*' --position anywhere --function __fish_h_all
      abbr -a '!^' --position anywhere --function __fish_h_first
      abbr -a '!:0' --position anywhere --function __fish_h_cmd

      function __fish_expand_or_execute
          set -l cmd (commandline -b)
          set -l words (string split " " -- $history[1])

          if string match -qr '^\^' -- $cmd
              set -l parts (string split "^" -- $cmd)
              if test (count $parts) -ge 3
                  commandline -r (string replace -- "$parts[2]" "$parts[3]" -- $history[1])
              end
              commandline -f execute
              return
          end

          for i in (seq 0 9)
              if string match -qr "!:$i" -- $cmd
                  set cmd (string replace -ra "!:$i" "$words[(math $i + 1)]" -- $cmd)
              end
          end

          if string match -qr '!\?' -- $cmd
              set -l m (string match -r '!\?([^ ]+)' -- $cmd)
              if set -q m[2]
                  for entry in $history
                      if string match -q "*$m[2]*" -- $entry
                          set cmd (string replace -ra '!\?[^ ]+' "$entry" -- $cmd)
                          break
                      end
                  end
              end
          end

          if string match -qr '!([a-zA-Z][a-zA-Z0-9._-]*)' -- $cmd
              set -l m (string match -ra '!([a-zA-Z][a-zA-Z0-9._-]*)' -- $cmd)
              for i in (seq 2 2 (count $m))
                  for entry in $history
                      if string match -q "$m[$i]*" -- $entry
                          set cmd (string replace -ra "!$m[$i]" "$entry" -- $cmd)
                          break
                      end
                  end
              end
          end

          commandline -r $cmd
          commandline -f execute
      end

      function fish_user_key_bindings
          bind \n __fish_expand_or_execute
      end

      function doas
          if test "$argv" = "!!"
              command doas $history[1]
          else if test "$argv" = '!$'
              command doas (string split " " -- $history[1] | tail -1)
          else
              command doas $argv
          end
      end
    '';
  };
}
