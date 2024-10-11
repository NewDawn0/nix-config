{ pkgs, ... }: {
  fonts = {
    packages = with pkgs; [
      font-awesome
      (nerdfonts.override {
        fonts = [
          "DroidSansMono"
          "FiraCode"
          "Hack"
          "Hermit"
          "Iosevka"
          "JetBrainsMono"
          "Meslo"
          "VictorMono"
        ];
      })
    ];
  };
}
