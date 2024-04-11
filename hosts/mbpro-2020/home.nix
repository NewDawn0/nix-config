{ pkgs, unstable, ... }: {
  imports = [ ../../shared/home-manager/darwin ../../shared/home-manager/all ];
  home.packages = with pkgs; [ neovim ];
}
