{ config, lib, pkgs, unstable, ... }: {
  options = {
    pkgs-langs-nixCfg.enable =
      lib.mkEnableOption "enable nix lang package config";
  };

  config = lib.mkIf config.pkgs-langs-nixCfg.enable {
    home = {
      packages = with pkgs; [ alejandra unstable.nixfmt-classic ];
      shellAliases = { nix-format = ''alejandra "$1" && nixfmt "$1"''; };
    };
  };
}
