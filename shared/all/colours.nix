{ config, lib, base16, inputs, ... }: {
  imports = [ base16.nixosModule ];
  options = {
    colorSchemeCfg.enable = lib.mkEnableOption "enable colour scheme config";
  };
  config = lib.mkIf config.colorSchemeCfg.enable {
    scheme = "${inputs.tt-schemes}/base24/one-dark.yaml";
  };
}
