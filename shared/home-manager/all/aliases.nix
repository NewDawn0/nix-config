{ config, lib, ... }: {
  options = { aliasesCfg.enable = lib.mkEnableOption "enable aliases config"; };

  config = lib.mkIf config.aliasesCfg.enable {
    home.shellAliases = {
      nix-flake-update = ''
        for dir1 in ./custom/*/; do (for dir2 in "$dir1"/*/; do (if [ -d "$dir2" ]; then (cd "$dir2" && nix flake update) fi) done) done && nix flake update
      '';
      diff = "diff --color -u";
    };
  };
}
