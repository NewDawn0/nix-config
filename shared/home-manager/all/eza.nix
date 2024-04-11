{ config, lib, ... }: {
  options = { ezaCfg.enable = lib.mkEnableOption "enable eza config"; };

  config = lib.mkIf config.ezaCfg.enable {
    programs.eza = {
      enable = true;
      enableBashIntegration = true;
      enableNushellIntegration = true;
      enableZshIntegration = true;
      git = false;
      icons = true;
    };
  };
}
