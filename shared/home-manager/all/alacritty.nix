{ pkgs, ... }: {
  programs.alacritty = {
    enable = true;
    settings = {
      cursor = { style.shape = "Beam"; };
      font = {
        builtin_box_drawing = false;
        glyph_offset = {
          x = 0;
          y = 0;
        };
      };
      scrolling.history = 10000;
      shell = {
        args = [ "-l" ];
        program = "${pkgs.zsh}/bin/zsh";
      };
      window = {
        decorations = "none";
        dimensions = {
          columns = 80;
          lines = 24;
        };
        dynamic_title = true;
        option_as_alt = "None";
        padding = {
          x = 0;
          y = 0;
        };
        startup_mode = "Windowed";
        title = "Term";
      };
    };
  };
}
