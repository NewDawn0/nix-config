{ config, lib, pkgs, unstable, ... }: {
  options = { homeCfg.enable = lib.mkEnableOption "the home config"; };

  config = lib.mkIf config.homeCfg.enable {
    programs.home-manager.enable = true;
    home = {
      enableNixpkgsReleaseCheck = true;
      stateVersion = "24.05";
      sessionVariables = { PAGER = "less"; };
    };
  };
}
