{ config, inputs, lib, overlays, pkgs, self, unstable, userInfo, util, ... }:
let
  mkModule = prefix: path: name: enabled:
    let fname = lib.removeSuffix ".nix" (builtins.baseNameOf name);
    in {
      options = {
        "${prefix}${fname}Cfg".enable = lib.mkOption {
          type = lib.types.bool;
          default = enabled;
          description = "${fname} configuration";
        };
      };
      config = lib.mkIf config."${prefix}${fname}Cfg".enable
        (builtins.import "${path}/${name}" {
          inherit config inputs lib overlays pkgs self unstable userInfo util;
        });
    };

  mkModuleWrapper = with builtins;
    prefix: path: name:
    # Check all systems
    if match ".*all.*" (toString path) != null then
      [
        (mkModule prefix path name true)
      ]
      # Check darwin
    else if match ".*darwin.*" (toString path) != null
    && lib.hasSuffix "darwin" userInfo.system then
      [
        (mkModule prefix path name true)
      ]
      # Check linux 
    else if match ".*linux.*" (toString path) != null
    && lib.hasSuffix "linux" userInfo.system then
      [ (mkModule prefix path name true) ]
    else
      null;

  checkDirRec = path: prefix:
    let
      checkEntries = lib.mapAttrsToList (name: type:
        if type == "directory" then
          checkDirRec "${path}/${name}" "${prefix}${name}-"
        else if type == "regular" && lib.hasSuffix ".nix" name then
          mkModuleWrapper prefix path name
        else
          null) (builtins.readDir path);
      # Flatten list and remove nulls
      files =
        builtins.concatLists (builtins.filter (x: x != null) checkEntries);
    in files;

  /* ImportPath imports all the subsequent files in a path converts them to modules and enables/disables them
     @param: {path}    dir     -- The directory where files are taken from
  */
  importPath = path:
    if lib.hasSuffix "home-manager" (builtins.baseNameOf path) then
      checkDirRec path "hm-"
    else
      checkDirRec path "";
in importPath
