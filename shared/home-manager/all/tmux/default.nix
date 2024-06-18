{ config, lib, pkgs, ... }:
let themes = import ./themes.nix { inherit pkgs lib; };
in {
  options = { tmuxCfg.enable = lib.mkEnableOption "the tmux config"; };
  config = lib.mkIf config.tmuxCfg.enable {
    programs.tmux = {
      enable = true;
      baseIndex = 1;
      clock24 = false;
      keyMode = "vi";
      mouse = true;
      resizeAmount = 5;
      tmuxinator.enable = true;
      plugins = with pkgs.tmuxPlugins; [
        vim-tmux-navigator
        themes.everblush
        yank
      ];
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
    xdg.configFile."tmuxinator/build.yml".text = ''
      name: build
      root: .
      windows:
        - editor:
            layout: main-horizontal
            panes:
              - editor:
                - vim
              - build:
    '';
  };
}
