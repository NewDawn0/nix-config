{ inputs, self, home-manager, pkgs, unstable, userInfo, colorScheme, config, fn, ... }:
let scheme = config.scheme;
in {
  imports = [
    ../../shared/all
    ../../shared/darwin
    home-manager.darwinModules.home-manager
  ];
  home-manager = {
    extraSpecialArgs = { inherit inputs pkgs unstable userInfo scheme fn; };
    users.${userInfo.userName} = import ./home.nix;
  };
  programs = {
    zsh.enable = true;
    bash.enable = true;
  };
  environment.systemPackages = with pkgs; [ binutils coreutils less vim ];
}
