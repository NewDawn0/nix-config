{ pkgs, ... }:
pkgs.mkShell {
  buildInputs = with pkgs; [
    nix-prefetch
    nix-prefetch-git
    nix-prefetch-github
    nix-prefetch-docker
  ];
  meta = with pkgs.lib; {
    description = "All the fetchers";
    platforms = platforms.all;
  };
}
