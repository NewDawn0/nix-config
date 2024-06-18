{ config, lib, pkgs, unstable, ... }: {
  options = {
    pkgs-miscCfg.enable =
      lib.mkEnableOption "enable miscellaneous packages config";
  };

  config = lib.mkIf config.pkgs-miscCfg.enable {
    home.packages = with pkgs; [
      codespell
      didyoumean
      hunspell
      imagemagick
      qemu
      sqlite-utils
      texliveSmall
      timg
      typos
      unstable.ani-cli
      write-good
      ytfzf
    ];
  };
}
