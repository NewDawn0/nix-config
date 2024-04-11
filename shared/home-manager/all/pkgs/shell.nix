{ config, lib, pkgs, ... }: {
  options = {
    pkgs-shellCfg.enable = lib.mkEnableOption "enable shell packages config";
  };

  config = lib.mkIf config.pkgs-shellCfg.enable {
    home.packages = with pkgs; [
      ripgrep
      ffmpeg
      fd
      figlet
      file
      curl
      cpufetch
      gnused
      jq
      killall
      onefetch
      wget
    ];
  };
}
