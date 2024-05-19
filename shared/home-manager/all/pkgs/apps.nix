{ config, lib, pkgs, ... }: {
  options = {
    pkgs-appsCfg.enable = lib.mkEnableOption "the apps packages config";
  };

  config = lib.mkIf config.pkgs-appsCfg.enable {
    home.packages = with pkgs; [ discord gimp jetbrains.idea-community ];
  };
}
