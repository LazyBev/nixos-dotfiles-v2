{ inputs, pkgs, vars, ... }: let
  vars2 = import ../../vars.nix;
in {
  # ── Atuin ────────────────────────────────────────────────────────────────────
  programs.atuin = {
    enable = true;
    settings = {
      auto_sync = true;
      sync_frequency = "5m";
      search_mode = "fuzzy";
      filter_mode = "global";
      style = "compact";
      inline_height = 20;
      show_preview = true;
    };
  };

  # ── direnv ───────────────────────────────────────────────────────────────────
  programs.direnv = {
    enable = true;
    enableFishIntegration = true;
    nix-direnv.enable = true;
  };

  # ── Fish ─────────────────────────────────────────────────────────────────────
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
      ncUpd = "noctalia-shell ipc call state all > ${vars.repoDir}/modules/configs/apps/noctalia/noctalia.json";
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

  # ── Neovim (nvf) ─────────────────────────────────────────────────────────────
  imports = [ inputs.nvf.nixosModules.default ];

  programs.nvf = {
    enable = true;
    settings.vim = {
      viAlias = false;
      vimAlias = true;
      enableLuaLoader = true;
      extraPackages = with pkgs; [wl-clipboard];

      opts = {
        number = true;
        relativenumber = true;
        shiftwidth = 2;
        tabstop = 2;
        expandtab = true;
        mouse = "a";
        termguicolors = true;
        updatetime = 50;
        scrolloff = 8;
        signcolumn = "yes";
        smartcase = true;
        ignorecase = true;
        splitright = true;
        splitbelow = true;
        undofile = true;
        wrap = false;
        cursorline = true;
        clipboard = "unnamedplus";
      };

      theme = {
        enable = true;
        name = "dracula";
      };

      lsp = {
        enable = true;
        formatOnSave = true;
        lightbulb.enable = true;
        trouble.enable = true;
        lspSignature.enable = true;

        mappings = {
          goToDefinition = "gd";
          goToDeclaration = "gD";
          goToType = "<leader>D";
          listReferences = "gr";
          listImplementations = "gI";
          hover = "K";
          signatureHelp = "<C-k>";
          renameSymbol = "<leader>rn";
          codeAction = "<leader>ca";
          openDiagnosticFloat = "gl";
          nextDiagnostic = "]d";
          previousDiagnostic = "[d";
          listDocumentSymbols = "<leader>ls";
          listWorkspaceSymbols = "<leader>lS";
          format = "<leader>lf";
        };
      };

      languages = {
        enableTreesitter = true;
        enableExtraDiagnostics = true;
        enableFormat = true;
        nix.enable = true;
        markdown.enable = true;
        python.enable = true;
        rust.enable = true;
        typescript.enable = true;
        bash.enable = true;
        clang.enable = true;
        cmake.enable = true;
        go.enable = true;
        ocaml.enable = true;
        zig.enable = true;
      };

      autocomplete.nvim-cmp.enable = true;
      snippets.luasnip.enable = true;
      telescope.enable = true;
      tabline.nvimBufferline.enable = true;
      filetree.neo-tree.enable = true;

      statusline.lualine = {
        enable = true;
        theme = "auto";
      };

      dashboard.alpha = {
        enable = true;
        theme = "dashboard";
      };

      git = {
        enable = true;
        gitsigns.enable = true;
        neogit.enable = true;
      };

      comments.comment-nvim.enable = true;

      visuals = {
        indent-blankline.enable = true;
        nvim-cursorline.enable = true;
        fidget-nvim.enable = true;
      };

      binds.whichKey = {
        enable = true;
        setupOpts.preset = "modern";
      };

      ui.noice = {
        enable = true;
        setupOpts.presets = {
          bottom_search = true;
          command_palette = true;
          long_message_to_split = true;
          inc_rename = false;
          lsp_doc_border = true;
        };
      };

      notify.nvim-notify.enable = true;
      utility.motion.flash-nvim.enable = true;

      mini = {
        indentscope.enable = true;
        pairs.enable = true;
        surround.enable = true;
      };

      notes.todo-comments.enable = true;

      terminal.toggleterm = {
        enable = true;
        lazygit.enable = true;
      };

      luaConfigPost = ''
        local actions = require("telescope.actions")
        local action_state = require("telescope.actions.state")

        local function create_file(prompt_bufnr)
          local path = action_state.get_current_line()
          if path == "" then return end
          local dir = vim.fn.fnamemodify(path, ":h")
          if dir ~= "." then vim.fn.mkdir(dir, "p") end
          actions.close(prompt_bufnr)
          vim.cmd("edit " .. vim.fn.fnameescape(path))
        end

        require("telescope").setup({
          defaults = {
            mappings = {
              i = {
                ["<C-e>"] = create_file,
              },
              n = {
                ["<C-e>"] = create_file,
              },
            },
          },
        })
      '';

      autocmds = [
        {
          event = ["FileType"];
          pattern = ["alpha"];
          command = "nnoremap <buffer> q :q<CR>";
          desc = "Quit neovim from alpha dashboard";
        }
      ];

      keymaps = [
        {
          key = "<leader>w";
          mode = "n";
          action = "<cmd>w<CR>";
          silent = true;
          desc = "Save file";
        }
        {
          key = "<leader>q";
          mode = "n";
          action = "<cmd>q<CR>";
          silent = true;
          desc = "Quit";
        }
        {
          key = "<C-h>";
          mode = "n";
          action = "<cmd>wincmd h<CR>";
          desc = "Go to left window";
        }
        {
          key = "<C-j>";
          mode = "n";
          action = "<cmd>wincmd j<CR>";
          desc = "Go to bottom window";
        }
        {
          key = "<C-k>";
          mode = "n";
          action = "<cmd>wincmd k<CR>";
          desc = "Go to top window";
        }
        {
          key = "<C-l>";
          mode = "n";
          action = "<cmd>wincmd l<CR>";
          desc = "Go to right window";
        }
        {
          key = "<leader>e";
          mode = "n";
          action = "<cmd>Neotree toggle<CR>";
          silent = true;
          desc = "Toggle file tree";
        }
        {
          key = "<leader>ff";
          mode = "n";
          action = "<cmd>Telescope find_files<CR>";
          silent = true;
          desc = "Find files";
        }
        {
          key = "<leader>fg";
          mode = "n";
          action = "<cmd>Telescope live_grep<CR>";
          silent = true;
          desc = "Live grep";
        }
        {
          key = "<leader>fb";
          mode = "n";
          action = "<cmd>Telescope buffers<CR>";
          silent = true;
          desc = "Find buffers";
        }
        {
          key = "<leader>fr";
          mode = "n";
          action = "<cmd>Telescope resume<CR>";
          silent = true;
          desc = "Resume telescope";
        }
        {
          key = "<leader>gs";
          mode = "n";
          action = "<cmd>Neogit<CR>";
          silent = true;
          desc = "Git status";
        }
        {
          key = "<leader>th";
          mode = "n";
          action = "<cmd>Telescope help_tags<CR>";
          silent = true;
          desc = "Find help";
        }
        {
          key = "<leader>sr";
          mode = "n";
          action = "<cmd>%s///gc<Left><Left><Left>";
          silent = true;
          desc = "Search and replace";
        }
        {
          key = "<leader>c";
          mode = "n";
          action = "<cmd>nohlsearch<CR>";
          silent = true;
          desc = "Clear search highlights";
        }
        {
          key = "J";
          mode = "n";
          action = "mzJ`z";
          desc = "Join lines and keep cursor";
        }
        {
          key = "<C-up>";
          mode = "n";
          action = "<cmd>resize -2<CR>";
          desc = "Resize split up";
        }
        {
          key = "<C-down>";
          mode = "n";
          action = "<cmd>resize +2<CR>";
          desc = "Resize split down";
        }
        {
          key = "<C-left>";
          mode = "n";
          action = "<cmd>vertical resize -2<CR>";
          desc = "Resize split left";
        }
        {
          key = "<C-right>";
          mode = "n";
          action = "<cmd>vertical resize +2<CR>";
          desc = "Resize split right";
        }
        {
          key = "<leader>bb";
          mode = "n";
          action = "<cmd>e #<CR>";
          silent = true;
          desc = "Switch to other buffer";
        }
        {
          key = "<leader>?";
          mode = "n";
          action = "<cmd>WhichKey<CR>";
          silent = true;
          desc = "Show all keybinds";
        }
      ];
    };
  };

  # ── Starship ─────────────────────────────────────────────────────────────────
  programs.starship = {
    enable = true;
    settings = {
      palette = "dracula";

      palettes.dracula = {
        background = "#282a36";
        current_line = "#44475a";
        foreground = "#f8f8f2";
        comment = "#6272a4";
        cyan = "#8be9fd";
        green = "#50fa7b";
        orange = "#ffb86c";
        pink = "#ff79c6";
        purple = "#bd93f9";
        red = "#ff5555";
        yellow = "#f1fa8c";
      };

      character = {
        success_symbol = "[λ](purple)";
        error_symbol = "[λ](red)";
      };

      directory.style = "bold cyan";

      git_branch = {
        style = "purple";
        format = "[$symbol$branch]($style)";
      };

      git_status.style = "red";

      nodejs.style = "green";
      rust.style = "red";
      python.style = "yellow";
    };
  };

  # ── Packages ─────────────────────────────────────────────────────────────────
  environment.systemPackages = with pkgs; [
    # terminal
    alacritty zellij btop cava lazygit
    yazi tree zathura imv

    # media
    mpv rmpc poppler chafa
    ffmpegthumbnailer libnotify

    # gui
    thunar thunar-archive-plugin
    thunar-volman tumbler

    # browsing
    qutebrowser tor-browser

    # social
    gajim

    # dev
    delta opencode tinycc
    rust-stakeholder vscodium
    wl-clipboard pay-respects

    # virt
    qemu

    # games
    steam umu-launcher

    # vpn
    proton-vpn protonmail-desktop

    # themes
    catppuccin-sddm
    catppuccin-cursors.mochaMauve
    dracula-icon-theme
  ] ++ pkgs.lib.optional (vars2.systemTheme == "caelus") pkgs.caelus-theme
  ++ pkgs.lib.optional (vars2.systemTheme == "dracula") pkgs.dracula-theme
  ++ [
    (inputs.wrapper-modules.wrappers.noctalia-shell.wrap {
      inherit pkgs;
      settings =
        (builtins.fromJSON
          (builtins.readFile ../../configs/apps/noctalia/noctalia.json)).settings;
    })
  ];
}
