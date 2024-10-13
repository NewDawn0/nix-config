{ pkgs, ... }: {
  home.packages = with pkgs; [
    fastfetch
    figlet
    imagemagick
    onefetch
    qemu
    sqlite-utils
  ];
}
