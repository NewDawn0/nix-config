{ config, lib, ... }: {
  options = { pandocCfg.enable = lib.mkEnableOption "enable pandoc config"; };

  config = lib.mkIf config.pandocCfg.enable {
    programs.pandoc = {
      enable = true;
      defaults = { metadata.author = "NewDawn0"; };
    };
  };
}
