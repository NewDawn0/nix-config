{ config, lib, ... }: {
  options = { pandocCfg.enable = lib.mkEnableOption "the pandoc config"; };

  config = lib.mkIf config.pandocCfg.enable {
    programs.pandoc = {
      enable = true;
      defaults = { metadata.author = "NewDawn0"; };
    };
  };
}
