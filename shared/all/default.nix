{ lib, ... }: {
  imports = [ ./colours.nix ./nixcfg.nix ./users.nix ./fonts.nix ];

  colorSchemeCfg.enable = lib.mkDefault true;
  fontsCfg.enable = lib.mkDefault true;
  nixCfg.enable = lib.mkDefault true;
  usersCfg.enable = lib.mkDefault true;
}
