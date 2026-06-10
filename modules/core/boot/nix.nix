{ vars, ... }: {
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  nix.settings.max-jobs = vars.maxJobs;
  system.stateVersion = vars.stateVersion;
}
