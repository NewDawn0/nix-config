{ config, lib, ... }: {
  options = { xdgCfg.enable = lib.mkEnableOption "the xdg config"; };

  config = lib.mkIf config.xdgCfg.enable { xdg = { enable = true; }; };
}
