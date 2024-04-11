{ config, lib, pkgs, unstable, ... }: {
  options = { homeCfg.enable = lib.mkEnableOption "enable eza config"; };

  config = lib.mkIf config.homeCfg.enable {
    programs.home-manager.enable = true;
    home = {
      enableNixpkgsReleaseCheck = true;
      stateVersion = "23.11";
      sessionVariables = {
        EDITOR = "nvim";
        PAGER = "less -R ";
      };
      shellAliases = {
        nixgc = "nix-store --gc && nix-store --optimize";
        vim = "nvim";
        vi = "nvim";
        cp = "cp -i";
        mv = "mv -i";
      };
    };
  };
}
