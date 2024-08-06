{ config, lib, pkgs, ... }: {
  options = {
    pkgs-customCfg.enable = lib.mkEnableOption "the custom packages config";
  };

  config = lib.mkIf config.pkgs-customCfg.enable {
    home.packages = with pkgs; [
      (ndnvim.override { langs.all.enabled = true; })
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
