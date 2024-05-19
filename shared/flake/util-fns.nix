{ lib }:
with builtins;
with lib;
let
  /* Gets all the items in a dir without the default.nix
     @note: needs to be a function otherwise it will aways return the content of this dir
     @param: {path}    dir     -- the directory to list
     @example: `files ./.`
       -> `[ "a.nix" "b.nix" ]`
  */
  files = dir: filter (f: f != "default.nix") (attrNames (readDir dir));

  /* Merge list of attrs into single attrset
     @example: `mergeAttrs [ {a=1;} {b=2;} ]`
       -> `{a=1; b=2}`
  */
  mergeAttrs = attrs: foldl' (acc: next: acc // next) { } attrs;

  /* Creates a list of paths for all imports
     @param: {path}    dir     -- The directory where files are taken from
     @param: {lambda}  func    -- A lambda for creating file paths
     @example: `imports ./. (f: ./${f})`
       -> `[ <some/abs/path/to/a.nix> <some/abs/path/to/b.nix> ]`
  */
  imports = dir: func: map func (files dir);

  /* Sets `<prefix><filename>Cfg.enable = lib.mkDefault true;` for each file
     @param: {path}    dir     -- The directory where files are taken from
     @param: {string}  prefix  -- The prefix used in filenameCfg.enable option
     @example: `enableCfgs ./. "darwin-"`
       -> `[ {darwin-aCfg.enable = lib.mkDefault true;} {darwin-bCfg.enable=lib.mkDefault true;} ]`
  */
  enableCfgs = dir: prefix:
    map (f: attrsets.setAttrByPath [ f "enable" ] (mkDefault true))
    (map (f: "${prefix}${f}Cfg") (map (removeSuffix ".nix") (files dir)));

  /* Merges the imports (f1) and enableCfgs (f2)
     @param: {imports}     f1  -- The imports function
     @param: {enableCfgs}  f2  -- The enableCfgs function
     @example: `out imports enableCfgs` -- Assumes imports and enableCfgs exist
       -> `{imports = [./a.nix ./b.nix]; darwin-aCfg.enable=true; darwin-bCfg.enable=true;}`
  */
  out = f1: f2: { imports = f1; } // mergeAttrs f2;

  /* Auto generates and merges the imports & enableCfgs using a single dir path
     @param: {path}    dir     -- The directory where files are taken from
     @param: {lambda}  func    -- A lambda for creating file paths
     @param: {string}  prefix  -- The prefix used in filenameCfg.enable option
     @example: `auto-out ./. (f: ./${f}) "darwin-"`
       -> `{imports = [./a.nix ./b.nix]; darwin-aCfg.enable=true; darwin-bCfg.enable=true;}`
  */
  auto-out = dir: func: prefix:
    {
      imports = imports dir func;
    } // mergeAttrs (enableCfgs dir prefix);

  /* Gets the name of the current directory as a string
     @example: `pwd`
       -> `"flake"`
  */
  pwd = baseNameOf ./.;
in { inherit files mergeAttrs imports enableCfgs out auto-out pwd options; }
