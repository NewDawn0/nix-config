{ lib, ... }:
with builtins;
with lib;
let
  # Useful vars
  ## Get files/dirs
  files = filter (f: f != "default.nix") (attrNames (readDir ./.));
  ## Merge attrsets to single attrset
  mergeAttrs = attrs: foldl' (acc: next: acc // next) { } attrs;

  # @OUT <imports>
  ## Store all filepaths in list
  imports = map (f: ./${f}) files;
  # @OUT <enable>
  ## Convert filenames to file-basename + Cfg.enable = lib.mkDefault true
  ## eg. `a.nix -> aCfg.enable = lib.mkDefault true`
  enableCfgs = map (f: attrsets.setAttrByPath [ f "enable" ] (mkDefault true))
    (map (f: "${f}Cfg") (map (removeSuffix ".nix") files));

  # @FINAL <imports, enable>
  # Merge imports with options
  out = { inherit imports; } // mergeAttrs enableCfgs;
in out
