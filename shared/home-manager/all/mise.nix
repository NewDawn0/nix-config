{ config, lib, ... }: {
  options = { miseCfg.enable = lib.mkEnableOption "the mise config"; };

  config = lib.mkIf config.miseCfg.enable {
    programs.mise = {
      enable = true;
      enableBashIntegration = true;
      enableZshIntegration = true;
      globalConfig = {
        tools = {
          node = "lt";
          python = [ "3.12" ];
        };
      };
    };
  };
}
