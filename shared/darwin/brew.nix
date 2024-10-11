{ inputs, lib, userInfo, ... }: {
  inputs.nix-homebrew.darwinModules.nix-homebrew {
    nix-homebrew = {
      enable = true;
      enableRosetta = if lib.hasPrefix "aarch64" userInfo.system then true else false;
      user = userInfo.userName;
      mutableTaps = false;
    };
  }
}