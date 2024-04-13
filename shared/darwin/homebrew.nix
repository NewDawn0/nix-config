{ lib, config, ... }: {
  options = {
    homebrewCfg.enable = lib.mkEnableOption "enable darwin system config";
  };

  config = lib.mkIf config.homebrewCfg.enable {
    homebrew = {
      enable = true;
      global.autoUpdate = false;
      taps = [
        "homebrew/services"
        {
          name = "lencx/chatgp";
          clone_target = "https://github.com/lencx/ChatGPT.git";
        }
      ];
      brews = [ { name = "ghcup"; } { name = "openssl@3"; } ];
      onActivation = {
        autoUpdate = true;
        cleanup = "zap";
        upgrade = true;
      };
      masApps = {
        # Shazam = 897118787;
        MsExcel = 462058435;
        MsOutlook = 985367838;
        MsPowerPoint = 462062816;
        MsWord = 462054704;
        Xcode = 497799835;
      };
      casks = [
        "amethyst"
        "appcleaner"
        "balenaetcher"
        "blockbench"
        "chatgpt"
        "firefox"
        "github"
        "languagetool"
        "obs"
        "obsidian"
        "obsidian"
        "prismlauncher"
        "raycast"
        "vlc"
        "whatsapp"
      ];
    };
  };
}
