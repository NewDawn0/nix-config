{ config, lib, ... }: {
  options = { direnvCfg.enable = lib.mkEnableOption "enable direnv config"; };

  config = lib.mkIf config.direnvCfg.enable {
    programs.direnv = {
      enable = true;
      enableBashIntegration = true;
      enableNushellIntegration = true;
      enableZshIntegration = true;
      nix-direnv.enable = true;
    };
  };
}
