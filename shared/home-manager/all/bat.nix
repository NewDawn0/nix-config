{ config, lib, pkgs, ... }: {
  options = { batCfg.enable = lib.mkEnableOption "the bat config"; };

  config = lib.mkIf config.batCfg.enable {
    programs.bat = {
      enable = true;
      extraPackages = with pkgs.bat-extras; [ batman batgrep ];
      config.pager = "less";
      themes = {
        # Not set by default
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
