{ config, lib, ... }: {
  options = { manCfg.enable = lib.mkEnableOption "the man config"; };

  config = lib.mkIf config.manCfg.enable {
    programs.man = {
      enable = true;
      generateCaches = false;
    };
  };
}
