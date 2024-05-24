{ config, lib, pkgs, unstable, fn, ... }: {
  imports = fn.imports ./. (f: ./${f});

  options = {
    pkgs-langsCfg.enable =
      lib.mkEnableOption "the programming languages packages config";
  };

  config = lib.mkIf config.pkgs-langsCfg.enable
    ((fn.mergeAttrs (fn.enableCfgs ./. "pkgs-langs-")) // {
      home.packages = with pkgs; [
        # Any
        gawk
        go
        luajitPackages.luarocks
        nasm
        python3
        unstable.gleam
        zig
        # C/C++ dev
        cmake
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
    });
}
