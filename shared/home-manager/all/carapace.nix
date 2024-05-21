{ config, lib, ... }: {
  options = { carapaceCfg.enable = lib.mkEnableOption "the carapace config"; };

  config = lib.mkIf config.carapaceCfg.enable {
    programs.carapace = {
      enable = true;
      enableBashIntegration = true;
      enableNushellIntegration = true;
      enableZshIntegration = true;
    };
  };
}
