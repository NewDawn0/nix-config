{ pkgs, ... }: { home.packages = with pkgs; [ gradle maven openjdk ]; }
