{ config, lib, ... }: {
  options = { xdgCfg.enable = lib.mkEnableOption "enable xdg config"; };

  config = lib.mkIf config.xdgCfg.enable { xdg = { enable = true; }; };
}
