{ lib, ... }: {
  imports = [ ./aliases.nix ./amethyst.nix ./pkgs];

  darwin-amethystCfg.enable = lib.mkDefault true;
  darwin-aliasesCfg.enable = lib.mkDefault true;
  darwin-pkgsCfg.enable = lib.mkDefault true;
}
