{ config, lib, pkgs, ... }: {
  options = { nvimCfg.enable = lib.mkEnableOption "the neovim config"; };
  config = lib.mkIf config.alacrittyCfg.enable {
    programs.neovim = {
      enable = true;
      defaultEditor = true;
      viAlias = true;
      vimAlias = true;
      withNodeJs = true;
      withPython3 = true;
      withRuby = true;
    };
  };
}
