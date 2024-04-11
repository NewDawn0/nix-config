{ lib, ... }: {
  imports = [ ./amethyst.nix ./pkgs ];

  darwin-amethystCfg.enable = lib.mkDefault true;
  darwin-pkgsCfg.enable = lib.mkDefault true;
}
