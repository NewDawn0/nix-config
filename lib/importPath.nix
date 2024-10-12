{ config, home-manager, inputs, lib, overlays, pkgs, self, unstable, userInfo
, util, ... }:
let
  mkModule = prefix: path: file: enabled:
    let fname = lib.removeSuffix ".nix" (builtins.baseNameOf file);
    in {
      options = {
        "${prefix}${fname}Cfg".enable = lib.mkOption {
          type = lib.types.bool;
          default = enabled;
          description = "${fname} configuration";
        };
      };
      config = lib.mkIf config."${prefix}${fname}Cfg".enable
        (builtins.import "${path}/${file}" {
          inherit config home-manager inputs lib overlays pkgs self unstable
            userInfo util;
        });
    };

  checkDirRec = path: prefix:
    let
      checkEntries = lib.mapAttrsToList (name: type:
        if type == "directory" then
          checkDirRec "${path}/${name}" "${prefix}${name}-"
        else if type == "regular" && lib.hasSuffix ".nix" name then
        # Check if shared
          if builtins.baseNameOf path == "all" then
            [
              (mkModule prefix path name true)
            ]
            # Check if darwin system
          else if builtins.baseNameOf path == "darwin"
          && lib.hasSuffix "darwin" userInfo.system then
            [
              (mkModule prefix path name true)
            ]
            # Check if linux system
          else if builtins.baseNameOf path == "linux"
          && lib.hasSuffix "linux" userInfo.system then
            [ (mkModule prefix path name true) ]
          else
            null
        else
          null) (builtins.readDir path);
      # Flatten list and remove nulls
      files =
        builtins.concatLists (builtins.filter (x: x != null) checkEntries);
    in files;

  /* ImportPath imports all the subsequent files in a path converts them to modules and enables/disables them
     @param: {path}    dir     -- The directory where files are taken from
  */
  importPath = path: (checkDirRec path "");
in importPath
