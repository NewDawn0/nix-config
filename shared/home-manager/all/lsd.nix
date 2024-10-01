{ config, lib, ... }: {
  options = { lsdCfg.enable = lib.mkEnableOption "the lsd config"; };

  config = lib.mkIf config.lsdCfg.enable {
    programs.lsd = {
      enableAliases = true;
      enable = true;
    };
  };
}
