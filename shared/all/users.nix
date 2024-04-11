{ config, lib, userInfo, ... }: {
  options = {
    usersCfg.enable = lib.mkEnableOption "enable users config config";
  };
  config = lib.mkIf config.usersCfg.enable {
    users.users.${userInfo.userName} = {
      name = userInfo.userName;
      home = userInfo.userHome;
    };
  };
}
