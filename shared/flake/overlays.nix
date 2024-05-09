{ inputs }: [
  inputs.rust-overlay.overlays.default
  (final: prev: {
    ansi = inputs.nix-custom-pkgs.packages.${prev.system}.ansi;
    dirStack = inputs.nix-custom-pkgs.packages.${prev.system}.dirStack;
    ex = inputs.nix-custom-pkgs.packages.${prev.system}.ex;
    gen = inputs.nix-custom-pkgs.packages.${prev.system}.gen;
    nixie-clock = inputs.nix-custom-pkgs.packages.${prev.system}.nixie-clock;
    note = inputs.nix-custom-pkgs.packages.${prev.system}.note;
    notify = inputs.nix-custom-pkgs.packages.${prev.system}.notify;
    rgpt = inputs.nix-custom-pkgs.packages.${prev.system}.rgpt;
    translate = inputs.nix-custom-pkgs.packages.${prev.system}.translate;
    up = inputs.nix-custom-pkgs.packages.${prev.system}.up;
  })
  (final: prev:
    if prev.stdenv.isDarwin then {
      homebrew-manager =
        inputs.nix-custom-pkgs.packages.${prev.system}.homebrew-manager;
      mac-apps-archive =
        inputs.nix-custom-pkgs.packages.${prev.system}.mac-apps-archive;
    } else
      { })
  (final: prev: if prev.stdenv.isLinux then { } else { })
]
