{ self, userInfo, ... }: {
  documentation = {
    info.enable = false;
    doc.enable = false;
  };
  security.pam.enableSudoTouchIdAuth = true;
  system = {
    defaults = {
      dock = {
        appswitcher-all-displays = false;
        autohide = true;
        autohide-delay = 0.0;
        launchanim = true;
        magnification = false;
        orientation = "left";
        show-recents = false;
        showhidden = true;
        tilesize = 48;
      };
      loginwindow = {
        GuestEnabled = false;
        PowerOffDisabledWhileLoggedIn = false; 
        RestartDisabled = false;
        RestartDisabledWhileLoggedIn = false;
        SHOWFULLNAME = false;
        ShutDownDisabled = false;
        ShutDownDisabledWhileLoggedIn = false;
        SleepDisabled = false;
        autoLoginUser = "Off";
      };
      menuExtraClock = {
        Show24Hour = false;
        ShowAMPM = true;
        ShowDate = 0;
        ShowDayOfMonth = true;
        ShowDayOfWeek = true;
        ShowSeconds = true;
      };
      NSGlobalDomain = {
        # Trackpad
        "com.apple.sound.beep.feedback" = 0;
        "com.apple.sound.beep.volume" = 0.25;
        "com.apple.springing.delay" = 0.5;
        "com.apple.springing.enabled" = true;
        "com.apple.swipescrolldirection" = true;
        "com.apple.trackpad.enableSecondaryClick" = true;
        # Font
        AppleFontSmoothing = 2;
        AppleInterfaceStyleSwitchesAutomatically = false;
        # Units
        AppleMetricUnits = 1;
        # Finder
        AppleShowScrollBars = "Automatic";
        AppleTemperatureUnit = "Celsius";
        AppleScrollerPagingBehavior = false;
        AppleShowAllExtensions = true;
        AppleShowAllFiles = false;
        NSDocumentSaveNewDocumentsToCloud = false;
        NSTableViewDefaultSizeMode = 1;
        # Writing
        NSAutomaticCapitalizationEnabled = true;
        NSAutomaticDashSubstitutionEnabled = true;
        NSAutomaticPeriodSubstitutionEnabled = true;
        NSAutomaticQuoteSubstitutionEnabled = true;
        NSAutomaticSpellingCorrectionEnabled = false;
        NSTextShowsControlCharacters = false;
        NSUseAnimatedFocusRing = true;
        # Window
        NSAutomaticWindowAnimationsEnabled = true;
        NSDisableAutomaticTermination = false;
        NSWindowResizeTime = 1.0e-3;
        screensaver.askForPassword = true;
        spaces.spans-displays = false;
        # Keyboard
        InitialKeyRepeat = 15;
        KeyRepeat = 2;

        SoftwareUpdate.AutomaticallyInstallMacOSUpdates = true;

        trackpad = {
          ActuationStrength = 0;
          Clicking = true;
          Dragging = false;
          FirstClickThreshold = 0;
          SecondClickThreshold = 0;
          TrackpadRightClick = true;
          TrackpadThreeFingerDrag = false;
        };
      };
      networking = {
        computerName = userInfo.hostName;
        hostName = userInfo.hostName;
        localHostName = userInfo.hostName;
      };
    };
  };
}