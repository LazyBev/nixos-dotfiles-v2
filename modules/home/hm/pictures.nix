{ ... }: {
  home.file."Pictures" = {
    source = ../../../configs/desktop/Pictures;
    recursive = true;
  };
}
