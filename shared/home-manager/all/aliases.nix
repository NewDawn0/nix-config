{ config, lib, ... }: {
  options = { aliasesCfg.enable = lib.mkEnableOption "the aliases config"; };

  config = lib.mkIf config.aliasesCfg.enable {
    home.shellAliases = {
      cp = "cp -i";
      diff = "diff --color -u";
      grep = "grep --color=always";
      mv = "mv -i";
      nixgc = "nix-store --gc && nix-store --optimize";
      regit = "mv tmp/.git . && rmdir tmp";
      ungit = "mkdir -p tmp && mv .git tmp/";
    };
  };
}
