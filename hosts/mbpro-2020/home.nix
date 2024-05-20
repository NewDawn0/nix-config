{ pkgs, unstable, ... }: {
  imports = [ ../../shared/home-manager/darwin ../../shared/home-manager/all ];
  fehCfg.enable = false;
}
