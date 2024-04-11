{ config, lib, pkgs, scheme, ... }: {
  options = { zshCfg.enable = lib.mkEnableOption "enable zsh config"; };

  config = lib.mkIf config.zshCfg.enable {
    programs.zsh = {
      enable = true;
      autocd = false;
      completionInit = "autoload -U compinit && compinit";
      enableCompletion = true;
      syntaxHighlighting.enable = true;
      autosuggestion = {
        enable = true;
        highlight = with scheme.withHashtag; "fg=${base0E},bg=bold";
      };
      history = {
        ignoreAllDups = true;
        share = false;
        size = 10000;
      };
      initExtra = ''
        source ${pkgs.zsh-autopair}/share/zsh/zsh-autopair/autopair.zsh
        source ${pkgs.zsh-you-should-use}/share/zsh/plugins/you-should-use/you-should-use.plugin.zsh
        bindkey '^a' autosuggest-accept
        bindkey -v
        autopair-init
        function ds () {
            output=$(dirStack $*)
            while IFS= read -r line; do
                if [[ $line == EXEC:* ]]; then
                    eval "''${line#EXEC: }"
                else
                    echo -e $line
                fi
            done <<< "$output"
        }
        function up() {
            eval $(up-core "$@")
        }
      '';
    };
  };
}
