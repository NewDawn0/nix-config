{ pkgs, ... }: {
  programs.tmux = {
    baseIndex = 1;
    clock24 = false;
    customPaneNavigationAndResize = true;
    enable = true;
    keyMode = "emacs";
    mouse = true;
    resizeAmount = 5;
    sensibleOnTop = false;
    plugins = with pkgs.tmuxPlugins; [ vim-tmux-navigator yank ];
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

      # Visual
      set -g visual-activity off
      set -g visual-bell off
      set -g visual-silence off
      setw -g monitor-activity off
      set -g bell-action none

      setw -g clock-mode-colour yellow

      setw -g mode-style 'fg=black bg=red bold'

      set -g pane-border-style 'fg=red'
      set -g pane-active-border-style 'fg=yellow'

      set -g status-position bottom
      set -g status-justify left
      set -g status-style 'fg=red'

      set -g status-left '''
      set -g status-left-length 10

      set -g status-right-style 'fg=black bg=yellow'
      set -g status-right ' %Y-%m-%d %H:%M '
      set -g status-right-length 50

      setw -g window-status-current-style 'fg=black bg=red'
      setw -g window-status-current-format ' #I #W #F '
      setw -g window-status-style 'fg=red bg=black'

      setw -g window-status-format ' #I #[fg=white]#W #[fg=yellow]#F '
      set -g message-style 'fg=yellow bg=red bold'
    '';
  };
}
