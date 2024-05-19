{ config, lib, ... }:
with builtins;
with lib;
let
  # Useful vars
  files = filter (f: f != "default.nix") (attrNames (readDir ./.));
  mergeAttrs = attrs: foldl' (acc: next: acc // next) { } attrs;
  enableCfgs = map (f: attrsets.setAttrByPath [ f "enable" ] (mkDefault true))
    (map (f: "pkgs-${f}Cfg") (map (removeSuffix ".nix") files));
in {
  imports = map (f: ./${f}) files;
  options = { pkgsCfg.enable = lib.mkEnableOption "enable packages config"; };
  config = lib.mkIf config.pkgsCfg.enable (mergeAttrs enableCfgs);
}
