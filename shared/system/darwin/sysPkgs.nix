{ pkgs, ... }: {
  environment.systemPackages = with pkgs;
    builtins.attrValues darwin.apple_sdk.frameworks
    ++ [ darwin.libobjc darwin.libiconv pkg-config ];
}
