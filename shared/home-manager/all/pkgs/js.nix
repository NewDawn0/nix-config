{ pkgs, ... }: {
  home.packages = with pkgs; [
    nodePackages.live-server
    nodePackages.nodemon
    nodejs
  ];
}
