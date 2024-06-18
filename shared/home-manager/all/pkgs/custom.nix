{ config, lib, pkgs, ... }: {
  options = {
    pkgs-customCfg.enable = lib.mkEnableOption "the custom packages config";
  };

  config = lib.mkIf config.pkgs-customCfg.enable {
    home.packages = with pkgs; [
      ansi
      dirStack
      ex
      gen
      nixie-clock
      note
      notify
      translate
      up
      vocab
    ];
  };
}
