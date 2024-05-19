{ config, lib, ... }: {
  options = { aliasesCfg.enable = lib.mkEnableOption "the aliases config"; };

  config = lib.mkIf config.aliasesCfg.enable {
    home.shellAliases = {
      nix-flake-update = ''
        fd flake.nix | xargs dirname | xargs -I {} sh -c "cd {} && nix flake update"'';
      diff = "diff --color -u";
      nixgc = "nix-store --gc && nix-store --optimize";
      cp = "cp -i";
      mv = "mv -i";
    };
  };
}
