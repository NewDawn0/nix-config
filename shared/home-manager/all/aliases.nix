{ ... }: {
  home.shellAliases = {
    cp = "cp -i";
    grep = "grep --color=always";
    mv = "mv -i";
    nixgc = "nix-store --gc && nix-store --optimize";
    regit = "mv tmp/.git . && rmdir tmp";
    ungit = "mkdir -p tmp && mv .git tmp/";
  };
}
