{ lib, ... }: {
  imports = [
    ./alacritty.nix
    ./aliases.nix
    ./bash.nix
    ./bat.nix
    ./bottom.nix
    ./direnv.nix
    ./eza.nix
    ./feh.nix
    ./fzf.nix
    ./git.nix
    ./gnupg.nix
    ./home.nix
    ./jq.nix
    ./lang.nix
    ./man.nix
    ./mise.nix
    ./mpv.nix
    ./nushell.nix
    ./pandoc.nix
    ./pass.nix
    ./pkgs
    ./ssh.nix
    ./starship.nix
    ./thefuck.nix
    ./tmux
    ./vscode.nix
    ./xdg.nix
    ./yt-dlp.nix
    ./zathura.nix
    ./zsh.nix
  ];
  alacrittyCfg.enable = lib.mkDefault true;
  aliasesCfg.enable = lib.mkDefault true;
  bashCfg.enable = lib.mkDefault true;
  batCfg.enable = lib.mkDefault true;
  bottomCfg.enable = lib.mkDefault true;
  direnvCfg.enable = lib.mkDefault true;
  ezaCfg.enable = lib.mkDefault true;
  fehCfg.enable = lib.mkDefault true;
  fzfCfg.enable = lib.mkDefault true;
  ghCfg.enable = lib.mkDefault true;
  gitCfg.enable = lib.mkDefault true;
  gnupgCfg.enable = lib.mkDefault true;
  homeCfg.enable = lib.mkDefault true;
  jqCfg.enable = lib.mkDefault true;
  langCfg.enable = lib.mkDefault true;
  manCfg.enable = lib.mkDefault true;
  miseCfg.enable = lib.mkDefault true;
  mpvCfg.enable = lib.mkDefault true;
  nushellCfg.enable = lib.mkDefault true;
  pandocCfg.enable = lib.mkDefault true;
  password-storeCfg.enable = lib.mkDefault true;
  pkgsCfg.enable = lib.mkDefault true;
  sshCfg.enable = lib.mkDefault true;
  starshipCfg.enable = lib.mkDefault true;
  thefuckCfg.enable = lib.mkDefault true;
  tmuxCfg.enable = lib.mkDefault true;
  vscodeCfg.enable = lib.mkDefault true;
  xdgCfg.enable = lib.mkDefault true;
  yt-dlpCfg.enable = lib.mkDefault true;
  zathuraCfg.enable = lib.mkDefault true;
  zshCfg.enable = lib.mkDefault true;
}
