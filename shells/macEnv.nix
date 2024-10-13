{ pkgs, ... }:
pkgs.mkShell {
  buildInputs = with pkgs;
    builtins.attrValues darwin.apple_sdk.frameworks
    ++ [ darwin.libobjc darwin.libiconv pkg-config ];
  meta = with pkgs.lib; {
    description = "Mac build environment with all the frameworks, etc...";
    platforms = platforms.darwin;
  };
}
