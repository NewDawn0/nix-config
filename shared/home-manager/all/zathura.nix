{ config, lib, ... }: {
  options = { zathuraCfg.enable = lib.mkEnableOption "the zathura config"; };

  config = lib.mkIf config.zathuraCfg.enable {
    programs.zathura = {
      enable = true;
      mappings = {
        K = "navigate previous";
        J = "navigate next";
        "<Left>" = "navigate previous";
        "<Right>" = "navigate next";
      };
    };
  };
}
