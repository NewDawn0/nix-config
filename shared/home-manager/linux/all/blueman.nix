{ config, lib, ... }: {
  options = {
    bluemanCfg.enable = lib.mkEnableOption "enable blueman service config";
  };

  config = lib.mkIf config.bluemanCfg.enable {
    services.blueman-applet = { enable = true; };
  };
}
