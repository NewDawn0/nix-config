{ config, lib, pkgs, unstable, ... }: {
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
      nix-output-monitor
      nvd
      unstable.nh
      onefetch
      ripgrep
      wget
    ];
  };
}
