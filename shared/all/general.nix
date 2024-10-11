{ self, ... }: {
  system = {
    activationScripts.gc = {
      enable = true;
      text = ''
        nix-store --gc
      '';
    };
    configurationRevision = self.rev or self.dirtyRev or null;
    stateVersion = 5;
  };

}
