{ config, lib, pkgs, ... }:
let themes = import ./themes.nix { inherit pkgs lib; };
in {
  options = { tmuxCfg.enable = lib.mkEnableOption "enable tmux config"; };

  config = lib.mkIf config.tmuxCfg.enable {
    programs.tmux = {
      enable = true;
      baseIndex = 0;
      clock24 = false;
      keyMode = "vi";
      mouse = true;
      plugins = with pkgs.tmuxPlugins; [ vim-tmux-navigator themes.everblush ];
      prefix = "C-s";
      terminal = "screen-256color";
      extraConfig = ''
        bind-key h select-pane -L
        bind-key j select-pane -D
        bind-key k select-pane -U
        bind-key l select-pane -R
        set-option -g status-position top
      '';
    };
  };
}
