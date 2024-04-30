{ config, lib, ... }: {
  imports = [ ./custom.nix ./macLibs.nix ./misc.nix ];

  options = {
    darwin-pkgsCfg.enable = lib.mkEnableOption "enable darwin packages config";
  };

  config = lib.mkIf config.darwin-pkgsCfg.enable {
    darwin-pkgs-customCfg.enable = lib.mkDefault true;
    darwin-pkgs-macLibsCfg.enable = lib.mkdefault true;
    darwin-pkgs-miscCfg.enable = lib.mkDefault true;
  };
}
