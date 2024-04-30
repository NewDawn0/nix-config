{ config, lib, pkgs, ... }: {
  options = {
    darwin-pkgs-macLibsCfg.enable = lib.mkEnableOption "Enable "
  };
  config = lib.mkIf config.darwin-pkgs-macLibsCfg.enable {
    home.packages = with pkgs;
      builtins.attrValues darwin.apple_sdk.frameworks ++ 
      [ darwin.libobjc darwin.libiconv pkg-config ];
  };
}
