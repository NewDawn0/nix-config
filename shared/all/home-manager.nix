{ inputs, pkgs, unstable, userInfo, ... }: {
  home-manager = {
    extraSpecialArgs = { inherit inputs pkgs unstable userInfo; };
    users.${userInfo.userName} = import ./home.nix;
  };
}
