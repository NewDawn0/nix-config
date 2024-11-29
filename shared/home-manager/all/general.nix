{ config, lib, userInfo, ... }: {
  programs.home-manager.enable = true;
  xdg.enable = true;
  home = {
    enableNixpkgsReleaseCheck = true;
    stateVersion = builtins.substring 0 5 lib.version;
    sessionVariables = {
      EDITOR = "nvim";
      NIX_INSTALL_DIR = "/Users/dawn/GitHub/nixConfig";
      PAGER = "less";
      PATH = "$PATH:${userInfo.userHome}/go/bin/";
    };
    language = {
      measurement = "metric";
      base = "en_GB";
      ctype = "UTF-8";
      time = "en_GB";
    };
  };
}
