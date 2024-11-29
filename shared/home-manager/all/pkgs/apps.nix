{ pkgs, ... }: {
  home.packages = with pkgs; [
    blockbench
    discord
    gimp
    jetbrains.idea-community
    mpv
    # prismlauncher
  ];
}
