{ config, lib, ... }: {
  options = { zoxideCfg.enable = lib.mkEnableOption "the zoxide config"; };

  config = lib.mkIf config.zoxideCfg.enable {
    programs.zoxide = {
      enable = true;
      enableBashIntegration = true;
      enableZshIntegration = true;
    };
    home.shellAliases.cd = "z";
  };
}
