{ config, lib, ... }: {
  options = { bashCfg.enable = lib.mkEnableOption "enable bash config"; };

  config = lib.mkIf config.bashCfg.enable {
    programs.bash = {
      enable = true;
      enableCompletion = true;
      historyControl = [ "ignoredups" ];
      historyFileSize = 10000;
      historyIgnore = [ "ls" "exit" "cd" ];
    };
  };
}
