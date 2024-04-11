{ config, lib, pkgs, ... }: {
  options = { mpvCfg.enable = lib.mkEnableOption "enable mpv config"; };

  config = lib.mkIf config.mpvCfg.enable {
    programs.mpv = {
      enable = true;
      scriptOpts = { };
      scripts = with pkgs.mpvScripts; [ webtorrent-mpv-hook chapterskip ];
    };
  };
}
