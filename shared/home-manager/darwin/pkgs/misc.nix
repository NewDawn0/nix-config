{ config, lib, pkgs, unstable, ... }: {
  options = {
    darwin-pkgs-miscCfg.enable =
      lib.mkEnableOption "enable miscellaneous packages config";
  };

  config = lib.mkIf config.darwin-pkgs-miscCfg.enable {
    home.packages = with pkgs; [ iina ];
  };
}
