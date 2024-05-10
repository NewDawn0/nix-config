{ config, lib, ... }: with builtins; with lib; let
  files = filter (f: f != "default.nix") (attrNames (readDir ./.));
  mergeAttrs = attrs: foldl' (acc: next: acc // next) { } attrs;
  cfgFilesSet = map (f: attrsets.setAttrByPath [ f "enable" ] (mkDefault true))
    (map (f: "darwin-pkgs-${f}Cfg") (map (removeSuffix ".nix") files));
in {
  imports = map (f: ./${f}) files;
  options = {
    darwin-pkgsCfg.enable = lib.mkEnableOption "enable darwin packages config";
  };
  config = lib.mkIf config.pkgsCfg.enable (mergeAttrs cfgFilesSet);
}
