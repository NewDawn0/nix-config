{ config, lib, ... }: {
  options = { aliasesCfg.enable = lib.mkEnableOption "the aliases config"; };

  config = lib.mkIf config.aliasesCfg.enable {
    home.shellAliases = {
      cp = "cp -i";
      diff = "diff --color -u";
      grep = "grep --color=always";
      mv = "mv -i";
      nix-flake-update = ''
        fd flake.nix | xargs dirname | xargs -I {} sh -c "cd {} && nix flake update"'';
      nixgc = "nix-store --gc && nix-store --optimize";
      regit = "mv tmp/.git .";
      ungit = "mkdir -p tmp && mv .git tmp/";
      vi = "nvim";
      vim = "nvim";
    };
  };
}
