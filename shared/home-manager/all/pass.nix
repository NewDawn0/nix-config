{ config, lib, ... }: {
  options = {
    password-storeCfg.enable =
      lib.mkEnableOption "enable password-store config";
  };

  config = lib.mkIf config.password-storeCfg.enable {
    programs.password-store = { enable = true; };
  };
}
