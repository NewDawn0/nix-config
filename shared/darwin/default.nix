{ lib, ... }:
let
  fn = import ./../flake/util-fns.nix { inherit lib; };
  out = fn.auto-out ./. (f: ./${f}) "darwin-";
in out
