{ pkgs, ... }: { home.packages = with pkgs; [ gcc gnumake libcxxStdenv ]; }
