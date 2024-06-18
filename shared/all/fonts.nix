{ config, lib, pkgs, ... }: {
  options = { fontsCfg.enable = lib.mkEnableOption "the fonts config"; };

  config = lib.mkIf config.fontsCfg.enable {
    fonts = {
      packages = with pkgs; [
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
