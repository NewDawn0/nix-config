{ config, lib, ... }: {
  options = { thefuckCfg.enable = lib.mkEnableOption "enable thefuck config"; };

  config = lib.mkIf config.thefuckCfg.enable {
    programs.thefuck = {
      enable = true;
      enableBashIntegration = true;
      enableZshIntegration = true;
    };
  };
}
