{ config, lib, pkgs, unstable, ... }: {
  options = {
    pkgs-miscCfg.enable =
      lib.mkEnableOption "enable miscellaneous packages config";
  };

  config = lib.mkIf config.pkgs-miscCfg.enable {
    home.packages = with pkgs; [
      didyoumean
      hunspell
      imagemagick
      typos
      qemu
      unstable.ani-cli
    ];
  };
}
