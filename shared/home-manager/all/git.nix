{ config, lib, ... }: {
  options = {
    ghCfg.enable = lib.mkEnableOption "enable gh config";
    gitCfg.enable = lib.mkEnableOption "enable git config";
  };

  config = {
    programs.git = lib.mkIf config.gitCfg.enable {
      enable = true;
      userName = "NewDawn0";
      userEmail = "newdawn.v0.0+git@gmail.com";
      aliases = {
        am = "commit --amend";
        br = "branch";
        ch = "checkout";
        cm = "commit -m";
        df = "diff";
        pl = "pull";
        pu = "push";
        root = "rev-parse --show-toplevel";
        st = "status";
      };
      ignores = [
        # General
        ".DS_Store"
        ".idea"
        "*.swp"
        # Lang
        "node_modules"
        "npm-debug.log"
        "__pycache__"
        ".ipynb_checkpoints"
        "pytest_cache"
        ".mypy_cache"
        ".egg-info"
        "*.pyc"
        ".dSYM"
        ".o"
      ];
      extraConfig = {
        init.defaultBranch = "master";
        push.autoSetupRemote = true;
        pull.rebase = false;
      };
      diff-so-fancy.enable = true;
      lfs.enable = true;
      signing = {
        key = "0xF407CF2A283453F3";
        signByDefault = true;
      };
    };
    programs.gh = lib.mkIf config.ghCfg.enable {
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
