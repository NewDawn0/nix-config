{ config, lib, pkgs, ... }: {
  options = {
    pkgs-shellCfg.enable = lib.mkEnableOption "enable shell packages config";
  };

  config = lib.mkIf config.pkgs-shellCfg.enable {
    home.packages = with pkgs; [
      cpufetch
      cpufetch
      curl
      fd
      ffmpeg
      figlet
      file
      gnused
      jq
      killall
      neofetch
      onefetch
      ripgrep
      wget
    ];
  };
}
