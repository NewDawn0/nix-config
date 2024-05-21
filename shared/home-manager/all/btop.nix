{ config, lib, ... }: {
  options = { btopCfg.enable = lib.mkEnableOption "the btop config"; };

  config = lib.mkIf config.btopCfg.enable {
    programs.btop = {
      enable = true;
    };
  };
}
