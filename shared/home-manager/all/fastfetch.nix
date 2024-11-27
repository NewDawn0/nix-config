{ ... }: {
  programs.fastfetch = { enable = true; };
  xdg.configFile."fastfetch/ibm.jsonc" = {
    source = ../../nonNix/fastfetch/ibm.jsonc;
  };
  xdg.configFile."fastfetch/logos/ibm.txt" = {
    source = ../../nonNix/fastfetch/logos/ibm.txt;
  };
  xdg.configFile."fastfetch/megamind.jsonc" = {
    source = ../../nonNix/fastfetch/megamind.jsonc;
  };
  xdg.configFile."fastfetch/logos/megamind.txt" = {
    source = ../../nonNix/fastfetch/logos/megamind.txt;
  };
}
