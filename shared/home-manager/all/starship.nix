{ config, lib, scheme, ... }: {
  options = {
    starshipCfg.enable = lib.mkEnableOption "enable startship prompt config";
  };

  config = let
    lang = {
      style = "bg:color_blue";
      format = "[[ $symbol( $version) ](fg:color_bg3 bg:color_blue)]($style)";
    };
    git = {
      style = "bg:color_aqua";
      format =
        "[[($all_status$ahead_behind )](fg:color_bg3 bg:color_aqua)]($style)";
    };
  in lib.mkIf config.starshipCfg.enable {
    programs.starship = {
      enable = true;
      enableBashIntegration = true;
      enableNushellIntegration = true;
      enableZshIntegration = true;

      # Settings
      settings = {
        character = {
          disabled = false;
          error_symbol = "[x](bold fg:color_red)";
          success_symbol = "[](bold fg:color_green)";
          vimcmd_replace_one_symbol = "[](bold fg:color_purple)";
          vimcmd_replace_symbol = "[](bold fg:color_purple)";
          vimcmd_symbol = "[](bold fg:color_green)";
          vimcmd_visual_symbol = "[](bold fg:color_yellow)";
        };
        command_timeout = 2000;
        format =
          "[](color_orange)$os$username[](bg:color_yellow fg:color_orange)$directory[](fg:color_yellow bg:color_aqua)$git_branch$git_status[](fg:color_aqua bg:color_blue)$c$rust$golang$nodejs$php$java$kotlin$haskell$python[](fg:color_blue bg:color_purple)$docker_context[](fg:color_purple bg:color_bg3)$time[ ](fg:color_bg3)$line_break$character";

        # Theming
        palette = "default";
        palettes.default = with scheme.withHashtag; {
          color_fg0 = base07;
          color_bg1 = base10;
          color_bg3 = base11;
          color_blue = base16;
          color_aqua = base15;
          color_green = base14;
          color_orange = base09;
          color_purple = base17;
          color_red = base12;
          color_yellow = base0A;
        };

        # Individ
        os = {
          disabled = false;
          style = "bg:color_orange fg:color_bg3";
          symbols = {
            Alpine = "";
            Amazon = "";
            Android = "";
            Arch = "󰣇";
            Artix = "󰣇";
            CentOS = "";
            Debian = "󰣚";
            Fedora = "󰣛";
            Gentoo = "󰣨";
            Linux = "󰌽";
            Macos = "󰀵";
            Manjaro = "";
            Mint = "󰣭";
            Raspbian = "󰐿";
            RedHatEnterprise = "󱄛";
            Redhat = "󱄛";
            SUSE = "";
            Ubuntu = "󰕈";
            Windows = "󰍲";
          };
        };
        username = {
          format = "[ $user ]($style)";
          show_always = true;
          style_root = "bg:color_orange fg:color_bg3";
          style_user = "bg:color_orange fg:color_bg3";
        };
        directory = {
          format = "[ $path ]($style)";
          style = "fg:color_bg3 bg:color_yellow";
          substitutions = {
            "Developer" = "󰲋 ";
            "Documents" = "󰈙 ";
            "Downloads" = " ";
            "Music" = "󰝚 ";
            "Pictures" = " ";
          };
          truncation_length = 3;
          truncation_symbol = "…/";
        };
        git_branch = {
          symbol = "";
          inherit (git) style format;
        };
        git_status = { inherit (git) style format; };
        nodejs = {
          symbol = "";
          inherit (lang) style format;
        };
        c = {
          symbol = " ";
          inherit (lang) style format;
        };
        rust = {
          symbol = "";
          inherit (lang) style format;
        };
        golang = {
          symbol = "";
          inherit (lang) style format;
        };
        php = {
          symbol = "";
          inherit (lang) style format;
        };
        java = {
          symbol = " ";
          inherit (lang) style format;
        };
        kotlin = {
          symbol = "";
          inherit (lang) style format;
        };
        haskell = {
          symbol = "";
          inherit (lang) style format;
        };
        python = {
          symbol = "";
          inherit (lang) style format;
        };
        nix_shell = {
          symbol = "";
          inherit (lang) style format;
        };
        docker_context = {
          format = "[[ $symbol( $context) ](fg:color_bg3 bg:color_purple)]($style)";
          style = "bg:color_bg3";
          symbol = "";
        };
        time = {
          disabled = false;
          format = "[[  $time ](fg:color_yellow bg:color_bg3)]($style)";
          style = "bg:color_bg3";
          time_format = "%R";
        };
        line_break = { disabled = false; };
      };
    };
  };
}
