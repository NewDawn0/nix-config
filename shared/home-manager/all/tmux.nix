{ lib, pkgs, ... }:
let
  everblush = pkgs.tmuxPlugins.mkTmuxPlugin {
    pluginName = "everblush";
    version = "0.1.0";
    src = pkgs.fetchurl {
      url =
        "https://github.com/NewDawn0/everblush-tmux/archive/refs/tags/Release.tar.gz";
      sha256 = "sha256-7ks5qeDM6Sy7L9wDTSJ14/FeLzjDXv9y+VGg6w6G+hc=";
    };
    meta = with lib; {
      description = "Everblush tmux theme";
      homepage = "https://github.com/NewDawn0/everblush-tmux";
      license = licenses.mit;
      maintainers = with maintainers; [ "NewDawn0" ];
    };
  };
in {
  programs.tmux = {
    enable = true;
    baseIndex = 1;
    clock24 = false;
    keyMode = "vi";
    mouse = true;
    resizeAmount = 5;
    plugins = with pkgs.tmuxPlugins; [ everblush vim-tmux-navigator yank ];
    extraConfig = ''
      bind-key -T copy-mode-vi v send-keys -X begin-selection
      bind-key -T copy-mode-vi C-v send-keys -X rectangle-toggle
      bind-key -T copy-mode-vi y send-keys -X copy-selection-and-cancel
      bind-key v copy-mode

      bind '"' split-window -v -c "#{pane_current_path}"
      bind % split-window -h -c "#{pane_current_path}"

      bind-key h select-pane -L
      bind-key j select-pane -D
      bind-key k select-pane -U
      bind-key l select-pane -R

      set-option -g status-position top
      set-option -sa terminal-overrides ",xterm*:Tc"
    '';
  };
}
