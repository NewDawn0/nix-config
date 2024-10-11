{ config, home-manager, inputs, lib, overlays, pkgs, self, unstable, userInfo
, util, ... }:
let
  importPath = import ../../lib/importPath.nix {
    inherit config home-manager inputs lib overlays pkgs self unstable userInfo
      util;
  };
in {
  imports = importPath ../../shared;
  programs.zsh.enable = true;
  environment.systemPackages = with pkgs; [ ndnvim ];
}
