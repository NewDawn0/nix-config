{ inputs, nixpkgs, nixpkgs-unstable }:
let
  inherit (nixpkgs) lib;

  /* Produces userInfo (Info about the system), pkgs, unstable (unstable nixpkgs channel) & overlays
     @param:  {string}  system    -- the system architecture
     @param:  {string}  hostName  -- the hostname of the system
     @param:  {string}  userName  -- the name of the current user
  */
  mkArgs = system: hostName: userName:
    let
      overlays = import ./overlays.nix { inherit inputs; };
    in mkPkgs { inherit system overlays; }
      |> ({ pkgs, unstable }: {
        userInfo = {
          inherit hostName system userName;
          installPath = builtins.baseNameOf ./.;
          userHome = (if pkgs.stdenv.isDarwin then "/Users/" else "/home/")
            + userName;
        };
        inherit overlays pkgs unstable;
      });

  mkPkgs = { system, overlays ? [ ] }:
    let config = { allowUnfree = true; };
    in {
      pkgs = import nixpkgs { inherit config overlays system; };
      unstable = nixpkgs-unstable.legacyPackages.${system};
    };

  # Set up each shell in ../shells for each system
  mkShells = eachSystem (system:
    mkPkgs { inherit system; }
      |> ({ pkgs, unstable }: shellsForSystem pkgs unstable));

  # Set up each shell in ../shells
  shellsForSystem = pkgs: unstable:
    builtins.readDir ../shells
      |> builtins.attrNames
      |> lib.map (f: let val = lib.removeSuffix ".nix" f; in {
        "${val}" = pkgs.callPackage ../shells/${f} { inherit pkgs unstable; };
      })
      |> mergeAttrs;

  eachSystem = nixpkgs.lib.genAttrs (import inputs.nix-systems);
  mergeAttrs = attrs: attrs |> builtins.foldl' (acc: next: acc // next) { };
in { inherit mkArgs mkShells; }
