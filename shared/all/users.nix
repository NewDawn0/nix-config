{ config, lib, userInfo, ... }: {
  options = { usersCfg.enable = lib.mkEnableOption "the users config"; };
  config = lib.mkIf config.usersCfg.enable {
    users.users.${userInfo.userName} = {
      name = userInfo.userName;
      home = userInfo.userHome;
    };
  };
}
