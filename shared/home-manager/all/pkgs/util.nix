{ pkgs, ... }: {
  home.packages = with pkgs; [
    colima
    docker
    fastfetch
    figlet
    imagemagick
    onefetch
    qemu
    sqlite-utils
  ];
}
