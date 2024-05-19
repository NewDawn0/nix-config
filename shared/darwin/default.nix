{ lib, ... }: 
with builtins;
with lib;
let
  # Useful vars
  files = filter (f: f != "default.nix") (attrNames (readDir ./.));
  mergeAttrs = attrs: foldl' (acc: next: acc // next) { } attrs;
  # @OUT <imports>
  imports = map (f: ./${f}) files;
  # @OUT <enable>
  enableCfgs = map (f: attrsets.setAttrByPath [ f "enable" ] (mkDefault true))
    (map (f: "darwin-${f}Cfg") (map (removeSuffix ".nix") files));
  # @FINAL <imports, enable>
  out = { inherit imports; } // mergeAttrs enableCfgs;
in out
