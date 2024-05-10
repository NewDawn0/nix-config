{ lib, ... }:
with builtins;
with lib;
let
  files = filter (f: f != "default.nix") (attrNames (readDir ./.));
  imports = map (f: ./${f}) files;
  cfgFilesSet = map (f: attrsets.setAttrByPath [ f "enable" ] (mkDefault true))
    (map (f: "darwin-${f}Cfg") (map (removeSuffix ".nix") files));
  mergeAttrs = attrs: foldl' (acc: next: acc // next) { } attrs;
  out = { inherit imports; } // mergeAttrs cfgFilesSet;
in out
