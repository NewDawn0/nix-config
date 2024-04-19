{ config, lib, pkgs, unstable, ... }: {
  imports = [ ./nix.nix ./rust.nix ];

  options = {
    pkgs-langsCfg.enable = lib.mkEnableOption "enable language packages config";
  };

  config = lib.mkIf config.pkgs-langsCfg.enable {
    pkgs-langs-rustCfg.enable = lib.mkDefault true;
    pkgs-langs-nixCfg.enable = lib.mkDefault true;

    home.packages = with pkgs; [
      # Any
      gawk
      go
      luajitPackages.luarocks
      nasm
      python3
      # C/C++ dev
      gcc
      gnumake
      libcxxStdenv
      # Docker
      colima
      docker
      # Haskell
      cabal-install
      ghc
      # Java
      gradle
      maven
      openjdk
      # JavaScript
      nodePackages.live-server
      nodePackages.nodemon
      nodejs
    ];
  };
}
