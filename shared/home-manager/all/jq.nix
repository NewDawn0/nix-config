{ ... }: {
  programs.jq = {
    enable = true;
    colors = {
      arrays = "1;36";
      false = "1;33";
      null = "1;31";
      numbers = "1;34";
      objects = "1;35";
      strings = "1;32";
      true = "1;33";
    };
  };
}
