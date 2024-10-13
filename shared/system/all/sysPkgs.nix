{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    (ndnvim.override { langs.all.enabled = true; })
    coreutils
    curl
    fd
    ffmpeg
    file
    git
    gnused
    killall
    less
    nixfmt-classic
    pkg-config
    ripgrep
    wget
  ];
}
