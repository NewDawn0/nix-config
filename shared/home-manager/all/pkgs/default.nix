{ config, lib, ... }: {
  imports = [ ./langs ./ai.nix ./apps.nix ./misc.nix ./shell.nix ./custom.nix ];

  options = { pkgsCfg.enable = lib.mkEnableOption "enable packages config"; };

  config = lib.mkIf config.pkgsCfg.enable {
    pkgs-langsCfg.enable = lib.mkDefault true;
    pkgs-aiCfg.enable = lib.mkDefault true;
    pkgs-miscCfg.enable = lib.mkDefault true;
    pkgs-appsCfg.enable = lib.mkDefault true;
    pkgs-shellCfg.enable = lib.mkDefault true;
    pkgs-customCfg.enable = lib.mkDefault true;
  };
}
