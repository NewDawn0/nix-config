{ config, lib, ... }: {
  options = { nushellCfg.enable = lib.mkEnableOption "the nushell config"; };

  config = lib.mkIf config.nushellCfg.enable {
    programs.nushell = {
      enable = true;
      configFile.text = ''
        let $config = {
          filesize_metric: false
          show_banner: false
          table_mode: rounded
          use_ls_colors: true
        }
      '';
    };
  };
}
