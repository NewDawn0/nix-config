{ config, lib, base16, inputs, ... }: {
  imports = [ base16.nixosModule ];
  options = {
    coloursCfg.enable = lib.mkEnableOption "the colour scheme config";
  };
  config = lib.mkIf config.coloursCfg.enable {
    scheme = "${inputs.tt-schemes}/base24/one-dark.yaml";
  };
}
