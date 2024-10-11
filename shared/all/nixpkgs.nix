{ overlays, userInfo, ... }: {
  # Nixpkgs
  nixpkgs = {
    config.allowUnfree = true;
    hostPlatform = userInfo.system;
    overlays = overlays;
  };
  # Nix settings
  services.nix-daemon.enable = true;
  nix.settings.experimental-features = "nix-command flakes";
}
