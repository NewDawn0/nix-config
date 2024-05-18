{ config, lib, scheme, ... }: {
  options = { fzfCfg.enable = lib.mkEnableOption "enable fzf config"; };

  config = lib.mkIf config.fzfCfg.enable {
    programs.fzf = {
      enable = true;
      enableBashIntegration = false;
      enableZshIntegration = false;
      tmux.enableShellIntegration = true;
      colors = with scheme.withHashtag; {
        prompt = base0E;
        hl = base0C;
        "hl+" = base15;
        fg = base06;
        "fg+" = base0A;
        pointer = base08;
        bg = base11;
        "bg+" = base11;
      };
    };
  };
}
