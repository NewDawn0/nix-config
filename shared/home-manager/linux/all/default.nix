{ lib, ... }: {
  imports = [ ./firefox.nix ./cava.nix ./blueman.nix ];

  firefoxCfg.enable = lib.mkDefault true;
  bluemanCfg.enable = lib.mkDefault true;
  cavaCfg.enable = lib.mkDefault true;
}
