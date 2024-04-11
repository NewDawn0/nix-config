{ config, lib, pkgs, ... }: {
  options = {
    pkgs-aiCfg.enable = lib.mkEnableOption "enable ai packages config";
  };

  config = lib.mkIf config.pkgs-aiCfg.enable {
    home.packages = with pkgs; [ tgpt ollama ];
  };
}
