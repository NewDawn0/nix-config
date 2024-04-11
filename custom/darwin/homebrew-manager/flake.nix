{
  description = "An archive extractor";

  inputs = { nixpkgs.url = "github:nixos/nixpkgs"; };

  outputs = { self, nixpkgs, ... }@inputs:
    let
      eachSystem = nixpkgs.lib.genAttrs [ "x86_64-darwin" "aarch64-darwin" ];
      mkPkgs = system:
        import nixpkgs {
          inherit system;
          config.allowUnfree = true;
        };
    in {
      packages = eachSystem (system:
        let pkgs = mkPkgs system;
        in {
          default = pkgs.writeShellScriptBin "homebrew-manager" ''
            if [ "$1" == "install" ]; then
                echo "Escalating privileges"
                sudo printf ""
                NONINTERACTIVE=1 ${pkgs.bash}/bin/bash -c "$(${pkgs.curl}/bin/curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
                echo "Successfully installed Homebrew";
            elif [ "$1" == "uninstall" ]; then
                prefix="$(brew --prefix)"
                echo "Escalating privileges"
                sudo printf ""
                brew ls --casks | xargs brew uninstall
                brew ls --formula | xargs brew uninstall
                brew tap | xargs brew untap
                NONINTERACTIVE=1 ${pkgs.bash}/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/uninstall.sh)"
                sudo rm -rf ''${prefix}/Caskroom/ ''${prefix}/Homebrew/ ''${prefix}/Cellar
                echo "Successfully uninstalled Homebrew";
            else
                echo "Usage: homebrew-manager [install|uninstall]"
            fi
          '';
        });
    };
}
