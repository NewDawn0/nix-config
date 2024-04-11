{ config, lib, pkgs, ... }: {
  options = { fontsCfg.enable = lib.mkEnableOption "enable fonts config"; };

  config = lib.mkIf config.fontsCfg.enable {
    fonts = {
      fontDir.enable = true;
      fonts = with pkgs; [
        font-awesome
        (nerdfonts.override {
          fonts = [
            "DroidSansMono"
            "FiraCode"
            "Hack"
            "Hermit"
            "Iosevka"
            "JetBrainsMono"
            "Meslo"
            "VictorMono"
          ];
        })
      ];
    };
  };
}
