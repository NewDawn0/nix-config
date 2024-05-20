{ config, lib, ... }: {
  options = { fzfCfg.enable = lib.mkEnableOption "the fzf config"; };

  config = lib.mkIf config.fzfCfg.enable {
    programs.fzf = {
      enable = true;
      enableBashIntegration = false;
      enableZshIntegration = false;
      tmux.enableShellIntegration = true;
    };
  };
}
