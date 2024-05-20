{ config, lib, fn, ... }: {
  imports = fn.imports ./. (f: ./${f});
  options = {
    darwin-pkgsCfg.enable = lib.mkEnableOption "the packages config";
  };
  config = lib.mkIf config.darwin-pkgsCfg.enable
    (fn.mergeAttrs (fn.enableCfgs ./. "darwin-pkgs-"));
}
