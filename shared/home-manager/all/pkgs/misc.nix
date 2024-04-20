{ config, lib, pkgs, unstable, ... }: {
  options = {
    pkgs-miscCfg.enable =
      lib.mkEnableOption "enable miscellaneous packages config";
  };

  config = lib.mkIf config.pkgs-miscCfg.enable {
    home.packages = with pkgs; [
      didyoumean
      gnupg
      hunspell
      imagemagick
      qemu
      typos
      unstable.ani-cli
    ];
  };
}
