{ pkgs, ... }: {
  home = {
    packages = with pkgs; [
      cargo-binstall
      cargo-expand
      cargo-make
      cargo-update
      cargo-workspaces
      rustup
    ];
    shellAliases = {
      cargoin = "cargo binstall";
      cargols = "cargo install --list";
      cargorm = "cargo uninstall";
      cargoup = "cargo install-update -a";
    };
  };
}
