{ config, lib, inputs, userInfo, ... }:
let overlays = import ../flake/overlays.nix { inherit inputs; };
in {
  options = {
    nixCfg.enable = lib.mkEnableOption "the nix package manager config";
  };

  config = lib.mkIf config.nixCfg.enable {
    # Nixpkgs config
    nixpkgs = {
      config.allowUnfree = true;
      hostPlatform = userInfo.system;
      overlays = overlays;
    };

    # Enable daemon
    services.nix-daemon.enable = true;

    # Nix pkg manager config
    nix = {
      # Builders
      distributedBuilds = true;
      buildMachines = [{
        hostName = "eu.nixbuild.net";
        maxJobs = 100;
        supportedFeatures = [ "benchmark" "big-parallel" ];
        system = "x86_64-linux";
      }];

      # Enable flakes
      settings = {
        experimental-features = "nix-command flakes";
        substituters =
          [ "https://nix-community.cachix.org" "https://cache.nixos.org" ];
        trusted-public-keys = [
          "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
          "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
        ];
      };

      checkConfig = true;

      # Garbage collection
      gc = {
        automatic = true;
        options = "--delete-older-than 7d";
        user = "root";
        interval = {
          Hour = 2;
          Minute = 0;
          Weekday = 0;
        };
      };
    };
  };
}
