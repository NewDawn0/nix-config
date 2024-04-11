{ config, lib, ... }: {
  options = { sshCfg.enable = lib.mkEnableOption "enable ssh config"; };

  config = lib.mkIf config.sshCfg.enable {
    programs.ssh = {
      enable = true;
      extraConfig = "Include $HOME/.colima/ssh_config";
      hashKnownHosts = true;
    };
  };
}
