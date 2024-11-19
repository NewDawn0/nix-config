{ config, inputs, lib, overlays, pkgs, self, unstable, userInfo, util, ... }:
let
  importPath = import ../../lib/importPath.nix {
    inherit config inputs lib overlays pkgs self unstable userInfo util;
  };
in { imports = importPath ../../shared/home-manager; }
