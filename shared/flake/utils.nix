{ lib }: with builtins; with lib; {
  files = filter (f: f != "default.nix") (attrNames (readDir ./.));
  mergeAttrs = attrs: foldl' (acc: next: acc // next) { } attrs;
  # @OUT: <imports>
  imports = map (f: ./${f}) files;
  # @OUT: <fCfg.enable>
  enableCfgs = prefix: map (f: attrsets.setAttrByPath [ f "enable" ] (mkDefault true))
    (map (f: "${prefix}${f}Cfg") (map (removeSuffix ".nix") files));
}
