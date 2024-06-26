{ config, lib, pkgs, ... }: {
  options = {
    darwin-pkgs-miscCfg.enable =
      lib.mkEnableOption "enable darwin miscellaneous packages config";
  };

  config = lib.mkIf config.darwin-pkgs-miscCfg.enable {
    home.packages = with pkgs; [ iina ];
  };
}
