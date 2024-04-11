{ config, lib, pkgs, ... }: {
  options = { rustCfg.enable = lib.mkEnableOption "enable rust config"; };

  config = lib.mkIf config.rustCfg.enable {
    home = {
      packages = with pkgs; [ rustup cargo-binstall cargo-update ];
      shellAliases = {
        cargoin = "cargo binstall";
        cargorm = "cargo uninstall";
        cargoup = "cargo install-update -a";
      };
    };
  };
}
