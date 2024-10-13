{ ... }: {
  programs.ssh = {
    enable = true;
    extraConfig = "Include $HOME/.colima/ssh_config";
    hashKnownHosts = true;
  };
}
