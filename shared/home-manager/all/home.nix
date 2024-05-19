{ config, lib, pkgs, unstable, ... }: {
  options = { homeCfg.enable = lib.mkEnableOption "the eza config"; };

  config = lib.mkIf config.homeCfg.enable {
    programs.home-manager.enable = true;
    home = {
      enableNixpkgsReleaseCheck = true;
      stateVersion = "23.11";
      sessionVariables = { PAGER = "less -R "; };
    };
  };
}
