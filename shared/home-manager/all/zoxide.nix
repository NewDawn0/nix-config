{ ... }: {
  home.shellAliases.cd = "z";
  programs.zoxide = {
    enable = true;
    enableBashIntegration = true;
    enableZshIntegration = true;
  };
}
