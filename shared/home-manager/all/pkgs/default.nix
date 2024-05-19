{ config, lib, fn, ... }: {
  imports = fn.imports ./. (f: ./${f});
  options = { pkgsCfg.enable = lib.mkEnableOption "the packages config"; };
  config = lib.mkIf config.pkgsCfg.enable (fn.mergeAttrs (fn.enableCfgs ./. "pkgs-"));
}
