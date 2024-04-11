{ config, lib, pkgs, scheme, ... }: {
  options = {
    alacrittyCfg.enable = lib.mkEnableOption "enable alacritty config";
  };

  config = lib.mkIf config.alacrittyCfg.enable {
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
          bold = {
            family = "FiraCode Nerd Font";
            style = "Regular";
          };
          bold_italic = {
            family = "FiraCode Nerd Font";
            style = "Regular";
          };
          italic = {
            family = "FiraCode Nerd Font";
            style = "Regular";
          };
          normal = {
            family = "FiraCode Nerd Font";
            style = "Regular";
          };
          offset = {
            x = 0;
            y = 0;
          };
          size = 12.0;
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
          opacity = 0.95;
          option_as_alt = "None";
          padding = {
            x = 0;
            y = 0;
          };
          startup_mode = "Windowed";
          title = "Term";
        };
        colors = with scheme.withHashtag; {
          normal = {
            white = "${base06}";
            red = "${base08}";
            yellow = "${base13}";
            green = "${base0B}";
            cyan = "${base0C}";
            blue = "${base0D}";
            magenta = "${base0E}";
            black = "${base11}";
          };
          bright = {
            white = base07;
            red = base12;
            yellow = base0A;
            green = base14;
            cyan = base15;
            blue = base16;
            magenta = base17;
            black = base10;
          };
          footer_bar = {
            foreground = base01;
            background = base00;
          };
          search = {
            matches = {
              foreground = base13;
              background = base00;
            };
            focused_match = {
              foreground = base08;
              background = base00;
            };
          };
        };
      };
    };
  };
}
