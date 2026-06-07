{ pkgs, ... }: {
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
}