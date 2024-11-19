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

  mkModuleWrapper = prefix: path: name:
    let
      match = builtins.toString path |> builtins.match ".*(all|darwin|linux).*";
      suffixMatch = suf: lib.hasSuffix suf userInfo.system;
      mkIfMatch = sysType: match == [sysType];
      mkIfAllMatch = sysType: mkIfMatch sysType && suffixMatch sysType;
    in match != null
        |> (isMatch:
          if !isMatch then null
          else if mkIfMatch "all" then [ (mkModule prefix path name true) ]
          else if mkIfAllMatch "darwin" then [ (mkModule prefix path name true) ]
          else if mkIfAllMatch "linux" then [ (mkModule prefix path name true) ]
          else null);

  checkDirRec = path: prefix:
    builtins.readDir path
      |> lib.mapAttrsToList (name: type:
        if type == "directory" then
          checkDirRec "${path}/${name}" "${prefix}${name}-"
        else if type == "regular" && lib.hasSuffix ".nix" name then
          mkModuleWrapper prefix path name
        else null)
      |> builtins.filter (x: x != null)
      |> builtins.concatLists;

  /* ImportPath imports all the subsequent files in a path converts them to modules and enables/disables them
     @param: {path}    dir     -- The directory where files are taken from
  */
  importPath = path: path
    |> builtins.baseNameOf
    |> (base: if lib.hasSuffix "home-manager" base then
        checkDirRec path "hm-"
      else
        checkDirRec path "");
in importPath
