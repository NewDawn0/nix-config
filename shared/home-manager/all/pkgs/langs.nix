{ pkgs, ... }: {
  home.packages = with pkgs; [ cabal-install ghc go python3 zig alejandra ];
}
