{ config, lib, ... }: {
  options = { fehCfg.enable = lib.mkEnableOption "the feh config"; };

  config = lib.mkIf config.fehCfg.enable {
    programs.feh = {
      enable = true;
      keybindings = {
        next_img = [ "l" "Right" ];
        prev_img = [ "h" "Left" ];
        zoom_in = [ "k" "plus" ];
        zoom_out = [ "l" "minus" ];
      };
    };
  };
}
