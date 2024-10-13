{ ... }: {
  programs.fzf = {
    enable = true;
    enableBashIntegration = false;
    enableZshIntegration = false;
    tmux.enableShellIntegration = true;
  };
}
