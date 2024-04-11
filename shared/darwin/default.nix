{ lib, ... }: {
  imports = [ ./system.nix ./homebrew.nix ];

  homebrewCfg.enable = lib.mkDefault true;
  systemCfg.enable = lib.mkDefault true;
}
