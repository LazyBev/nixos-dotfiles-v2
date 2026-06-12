{ pkgs, inputs, ... }: {
  environment.systemPackages = with pkgs; [
    bash git vim curl wget gnumake gcc clang
    fzf fd ripgrep jq eza bat zoxide
    fastfetch file p7zip unzip unar
    e2fsprogs dosfstools just dysk gh
    ffmpeg tealdeer devenv
  ];
}
