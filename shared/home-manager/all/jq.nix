{ config, lib, ... }: {
  options = { jqCfg.enable = lib.mkEnableOption "the jq config"; };

  config = lib.mkIf config.jqCfg.enable {
    programs.jq = {
      enable = true;
      colors = {
        arrays = "1;36";
        false = "1;33";
        null = "1;31";
        numbers = "1;34";
        objects = "1;35";
        strings = "1;32";
        true = "1;33";
      };
    };
  };
}
