{
  description = "An archive extractor";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs";
    nix-systems.url = "github:nix-systems/default";
  };

  outputs = { self, nixpkgs, ... }@inputs:
    let
      eachSystem = nixpkgs.lib.genAttrs (import inputs.nix-systems);
      mkPkgs = system:
        import nixpkgs {
          inherit system;
          config.allowUnfree = true;
        };
    in {
      packages = eachSystem (system:
        let pkgs = mkPkgs system;
        in {
          default = pkgs.writeShellScriptBin "ex" ''
            function ex () {
                if [ -f "$1" ] ; then
                    base=$(basename "$1")
                    dirname="''${base%%.*}"
                    if [ -d "$dirname" ]; then
                        echo "[ERROR]: Directory '$dirname' already exists.."
                        exit 1
                    fi
                    mkdir -p "$dirname"
                    case $1 in
                        *.tar.bz2)   ${pkgs.gnutar}/bin/tar xjf   "$1" -C "$dirname"    ;;
                        *.tar.gz)    ${pkgs.gnutar}/bin/tar xzf   "$1" -C "$dirname"    ;;
                        *.bz2)       ${pkgs.bzip2}/bin/bunzip2    "$1" -C "$dirname"    ;;
                        *.rar)       ${pkgs.unrar}/bin/unrar x    "$1" -C "$dirname"    ;;
                        *.gz)        ${pkgs.gzip}/bin/gunzip      "$1" -C "$dirname"    ;;
                        *.tar)       ${pkgs.gnutar}/bin/tar xf    "$1" -C "$dirname"    ;;
                        *.tbz2)      ${pkgs.gnutar}/bin/tar xjf   "$1" -C "$dirname"    ;;
                        *.tgz)       ${pkgs.gnutar}/bin/tar xzf   "$1" -C "$dirname"    ;;
                        *.zip)       ${pkgs.unzip}/bin/unzip      "$1" -d "$dirname"    ;;
                        *.Z)         ${pkgs.gzip}/bin/uncompress  "$1" -C "$dirname"    ;;
                        *.7z)        ${pkgs.p7zip}/bin/7z x       "$1" -o "$dirname"    ;;
                        *.tar.xz)    ${pkgs.gnutar}/bin/tar xf    "$1" -C "$dirname"    ;;
                        *.tar.zst)   ${pkgs.zstd}/bin/unzstd      "$1" -o "$dirname"    ;;
                        *)           echo "'$1' cannot be extracted via ex()" && exit 1 ;;
                    esac
                else
                    echo "'$1' is not a valid file"
                    exit 1
                fi
            }
            ex "$@"
          '';
        });
    };
}
