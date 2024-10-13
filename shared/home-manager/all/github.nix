{ ... }: {
  programs.gh = {
    enable = true;
    gitCredentialHelper.enable = true;
    settings = {
      git_protocol = "ssh";
      aliases = {
        co = "pr checkout";
        pv = "pr view";
      };
    };
  };
}
