{ config, lib, pkgs, unstable, ... }: {
  options = { homeCfg.enable = lib.mkEnableOption "the home config"; };

  config = lib.mkIf config.homeCfg.enable {
    programs.home-manager.enable = true;
    home = {
      enableNixpkgsReleaseCheck = true;
      stateVersion = builtins.substring 0 5 lib.version;
      sessionVariables = { PAGER = "less"; };
    };
  };
}
