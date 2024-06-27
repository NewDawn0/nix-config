{ config, lib, pkgs, ... }: {
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
      # unstable.ani-cli # Will reanable until swift-5.8 builds
      write-good
      # ytfzf # Will reanable until swift-5.8 builds
    ];
  };
}
