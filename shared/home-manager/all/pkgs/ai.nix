{ config, lib, pkgs, ... }: {
  options = {
    pkgs-aiCfg.enable = lib.mkEnableOption "the ai packages config";
  };

  config = lib.mkIf config.pkgs-aiCfg.enable {
    home.packages = with pkgs; [ tgpt ollama ];
  };
}
