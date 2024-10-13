{ pkgs, lib, config, ... }: {
  # Activation script is called applications as only applications as the name works and executes the script
  system.activationScripts.applications.text = let
    frameworks = with builtins;
      map (f: "${f}/Library/Frameworks")
      (attrValues pkgs.darwin.apple_sdk.frameworks);
    libs = with pkgs.darwin; [ libiconv libobjc ];
  in lib.mkForce ''
    echo "setting up system-frameworks..."
    mkdir -p /Library/Frameworks
    for framework in ${builtins.toString frameworks}; do
      sudo ln -sf $framework/* /Library/Frameworks
    done
  '';
}
