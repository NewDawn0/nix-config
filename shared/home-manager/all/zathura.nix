{ config, lib, scheme, ... }: {
  options = { zathuraCfg.enable = lib.mkEnableOption "enable zathura config"; };

  config = lib.mkIf config.zathuraCfg.enable {
    programs.zathura = {
      enable = true;
      mappings = {
        K = "navigate previous";
        J = "navigate next";
        "<Left>" = "navigate previous";
        "<Right>" = "navigate next";
      };
      options = with scheme.withHashtag; {
        default-bg = base00;
        default-fg = base07;
      };
    };
  };
}
