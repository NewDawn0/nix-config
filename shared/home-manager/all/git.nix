{ config, lib, ... }: {
  options = { gitCfg.enable = lib.mkEnableOption "the git config"; };

  config = lib.mkIf config.gitCfg.enable {
    programs.git = {
      enable = true;
      userName = "NewDawn0";
      userEmail = "newdawn.v0.0+git@gmail.com";
      aliases = {
        br = "branch";
        ch = "checkout";
        cm = "commit -m";
        ca = "commit --amend";
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
      delta = {
        enable = true;
        options.side-by-side = true;
      };
      lfs.enable = true;
      signing = {
        key = "0xF407CF2A283453F3";
        signByDefault = true;
      };
    };
  };
}
