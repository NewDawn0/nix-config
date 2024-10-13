{ pkgs, ... }: { home.packages = with pkgs; [ python3 zig cabal-install ghc ]; }
