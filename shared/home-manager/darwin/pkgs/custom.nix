{ config, lib, pkgs, ... }: {
  options = {
    darwin-pkgs-customCfg.enable =
      lib.mkEnableOption "enable darwin custom packages config";
  };

  config = lib.mkIf config.darwin-pkgs-customCfg.enable {
    home.packages = with pkgs; [ homebrew-manager mac-apps-archive ];
  };
}
