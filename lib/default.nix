{ inputs, nixpkgs, nixpkgs-unstable }:
let
  /* Produces userInfo (Info about the system), pkgs, unstable (unstable nixpkgs channel) & overlays
     @param: {string}  system    -- the system architecture
     @param: {string}  hostName  -- the hostname of the system
     @param: {string}  userName  -- the name of the current user
  */
  mkArgs = system: hostName: userName:
    let
      overlays = import ./overlays.nix { inherit inputs; };
      config = { allowUnfree = true; };
      unstable = nixpkgs-unstable.legacyPackages.${system};
      pkgs = import nixpkgs { inherit config overlays system; };
      userInfo = {
        inherit hostName system userName;
        installPath = builtins.baseNameOf ./.;
        userHome = (if pkgs.stdenv.isDarwin then "/Users/" else "/home/")
          + userName;
      };
    in { inherit overlays pkgs unstable userInfo; };
in { inherit mkArgs; }
