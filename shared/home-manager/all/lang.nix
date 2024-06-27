{ config, lib, ... }: {
  options = { langCfg.enable = lib.mkEnableOption "the language config"; };
  config = lib.mkIf config.langCfg.enable {
    home.language = {
      measurement = "metric";
      base = "en_GB";
      ctype = "UTF-8";
      time = "en_GB";
    };
  };
}
