{ pkgs, ... }:
pkgs.mkShell {
  buildInputs = with pkgs; [
    nix-prefetch
    nix-prefetch-docker
    nix-prefetch-git
    nix-prefetch-github
  ];
  meta = with pkgs.lib; {
    description = "All the fetchers";
    platforms = platforms.all;
  };
}
