{ config, lib, ... }: {
  options = { ghCfg.enable = lib.mkEnableOption "the gh config"; };

  config = lib.mkIf config.ghCfg.enable {
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
  };
}
