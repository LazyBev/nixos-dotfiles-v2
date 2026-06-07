{ pkgs, ... }: {
  programs.tmux = {
    enable = true;
    historyLimit = 100000;
    keyMode = "vi";
    escapeTime = 0;
    baseIndex = 1;
    plugins = with pkgs.tmuxPlugins; [
      catppuccin
    ];
    extraConfig = ''
      set -g default-terminal "tmux-256color"
      set -ga terminal-overrides ",*256col*:Tc"
      set -g status-right "#[fg=#bd93f9]%H:%M:%S "
      set -g @catppuccin_flavor 'mocha'
      set -g status-left ""
      set -g status-right-length 100
      setw -g mode-keys vi
      bind n next-window
      bind p previous-window
      bind -r J resize-pane -D 5
      bind -r K resize-pane -U 5
      bind -r L resize-pane -R 5
      bind -r H resize-pane -L 5
    '';
  };
}
