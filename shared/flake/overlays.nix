{ inputs }: [
  inputs.rust-overlay.overlays.default
  (final: prev: {
    ansi = inputs.custom-all.packages.${prev.system}.ansi;
    dirStack = inputs.custom-all.packages.${prev.system}.dirStack;
    ex = inputs.custom-all.packages.${prev.system}.ex;
    gen = inputs.custom-all.packages.${prev.system}.gen;
    note = inputs.custom-all.packages.${prev.system}.note;
    up = inputs.custom-all.packages.${prev.system}.up;
    rgpt = inputs.custom-all.packages.${prev.system}.rgpt;
    translate = inputs.custom-all.packages.${prev.system}.translate;
    nixie-clock = inputs.custom-all.packages.${prev.system}.nixie-clock;
  })
  (final: prev:
    if prev.stdenv.isDarwin then {
      homebrew-manager =
        inputs.custom-darwin.packages.${prev.system}.homebrew-manager;
      mac-util-apps =
        inputs.custom-darwin.packages.${prev.system}.mac-util-apps;
    } else
      { })
  (final: prev: if prev.stdenv.isLinux then { } else { })
]
