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
      inherit (mkPkgs system overlays) pkgs unstable;
      userInfo = {
        inherit hostName system userName;
        installPath = builtins.baseNameOf ./.;
        userHome = (if pkgs.stdenv.isDarwin then "/Users/" else "/home/")
          + userName;
      };
    in { inherit overlays pkgs unstable userInfo; };

  mkPkgs = system: overlays:
    let config = { allowUnfree = true; };
    in {
      pkgs = import nixpkgs { inherit config overlays system; };
      unstable = nixpkgs-unstable.legacyPackages.${system};
    };

  # Set up each shell in ../shells for each system
  mkShells = eachSystem (system:
    let inherit (mkPkgs system) pkgs unstable;
    in shellsForSystem pkgs unstable);

  # Set up each shell in ../shells
  shellsForSystem = pkgs: unstable:
    let
      files = with builtins; attrNames (readDir ../shells);
      fnames = builtins.map (f: lib.removeSuffix ".nix" f) files;
      shellAttrs = builtins.map (f: lib.attrsets.setAttrByPath [ f ] f) fnames;
    in mergeAttrs shellAttrs;

  eachSystem = nixpkgs.lib.genAttrs (import inputs.nix-systems);
  mergeAttrs = attrs: builtins.foldl' (acc: next: acc // next) { } attrs;
in { inherit mkArgs mkShells; }
