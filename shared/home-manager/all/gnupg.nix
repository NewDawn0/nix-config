{ config, lib, ... }: {
  options = { gnupgCfg.enable = lib.mkEnableOption "the gpg config"; };

  config = lib.mkIf config.gnupgCfg.enable {
    programs.gpg = {
      enable = true;
      homedir = "${config.xdg.dataHome}/gnupg";
      mutableKeys = true;
      mutableTrust = true;
    };
  };
}
