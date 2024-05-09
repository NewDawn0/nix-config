{ config, lib, ... }: {
  options = {
    darwin-aliasesCfg.enable =
      lib.mkEnableOption "enable darwin aliases config";
  };

  config = lib.mkIf config.darwin-aliasesCfg.enable {
    home.shellAliases = { neofetch = "fastfetch -c neofetch -l mac"; };
  };
}
