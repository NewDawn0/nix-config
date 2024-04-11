{ config, lib, pkgs, ... }: {
  options = { batCfg.enable = lib.mkEnableOption "enable bat config"; };

  config = lib.mkIf config.batCfg.enable {
    programs.bat = {
      enable = true;
      extraPackages = with pkgs.bat-extras; [ batman batgrep ];
      config = {
        pager = "less";
        theme = "everblush";
      };
      themes = {
        everblush = {
          file = "Everblush.tmTheme";
          src = pkgs.fetchFromGitHub {
            owner = "Everblush";
            repo = "bat";
            rev = "main";
            sha256 = "sha256-DuHV2IjJq1F/AX/QIarJCDdzycayqPbUHK9hCCvKOcM=";
          };
        };
      };
    };
  };
}
