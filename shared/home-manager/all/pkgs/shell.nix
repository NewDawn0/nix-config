{ config, lib, pkgs, unstable, ... }: {
  options = {
    pkgs-shellCfg.enable = lib.mkEnableOption "the shell packages config";
  };

  config = lib.mkIf config.pkgs-shellCfg.enable {
    home.packages = with pkgs; [
      cpufetch
      curl
      entr
      fastfetch
      fd
      ffmpeg
      figlet
      file
      gitleaks
      gnused
      jq
      killall
      nix-output-monitor
      nvd
      onefetch
      ripgrep
      unstable.nh
      wget
    ];
  };
}
