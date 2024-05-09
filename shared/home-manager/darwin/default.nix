{ lib, ... }:
with builtins;
with lib;
let
  # Get files/dirs
  files = filter (f: f != "default.nix") (attrNames (readDir ./.));
  # Store all filepaths in list
  imports = map (f: ./${f}) files;
  # Convert filenames to file-basename + Cfg.enable = lib.mkDefault true
  # eg. `a.nix -> aCfg.enable = lib.mkDefault true`
  cfgFilesSet = map (f: attrsets.setAttrByPath [ f "enable" ] (mkDefault true))
    (map (f: "darwin-${f}Cfg") (map (removeSuffix ".nix") files));
  # Merge attrsets to single attrset
  mergeAttrs = attrs: foldl' (acc: next: acc // next) { } attrs;
  # Merge imports with options
  out = { inherit imports; } // mergeAttrs cfgFilesSet;
in out
