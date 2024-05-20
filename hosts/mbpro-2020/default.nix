{ inputs, self, pkgs, unstable, userInfo, config, fn, ... }: {
  imports = [
    ../../shared/all
    ../../shared/darwin
    inputs.home-manager.darwinModules.home-manager
    inputs.stylix.darwinModules.stylix
  ];
  home-manager = {
    extraSpecialArgs = { inherit inputs pkgs unstable userInfo fn; };
    users.${userInfo.userName} = import ./home.nix;
  };
  programs = {
    zsh.enable = true;
    bash.enable = true;
  };
  environment.systemPackages = with pkgs; [ binutils coreutils less vim ];
}
