{ ... }: {
  programs.pandoc = {
    enable = true;
    defaults = { metadata.author = "NewDawn0"; };
  };
}
