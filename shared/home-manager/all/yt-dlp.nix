{ config, lib, pkgs, unstable, ... }: {
  options = { yt-dlpCfg.enable = lib.mkEnableOption "the yt-dlp config"; };

  config = lib.mkIf config.yt-dlpCfg.enable {
    home.packages = with pkgs; [ aria ];
    programs.yt-dlp = {
      enable = true;
      package = unstable.yt-dlp;
      extraConfig = ''
        --update
        -F
      '';
      settings = {
        downloader = "aria2c";
        downloader-args = "aria2c:'-c -x8 -s8 -k1M'";
        embed-subs = true;
        embed-thumbnail = true;
        sub-langs = "all";
      };
    };
  };
}
