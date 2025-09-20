{
  config,
  inputs,
  lib,
  pkgs,
  specialArgs,
  ...
}: let
  args = specialArgs.workstationArgs;
  hostName = args.system.hostName;
  platform = args.system.platform;
  userId = args.user.id;
  userTimezone = args.user.timezone;
in {
  environment.shells = with pkgs; [zsh];
  networking.computerName = hostName;
  security.pam.enableSudoTouchIdAuth = true;
  time.timeZone = userTimezone;

  fonts = {
    packages = with pkgs; [
      (nerdfonts.override {fonts = ["InconsolataLGC"];})
    ];
  };

  services = {
  };

  system.defaults = {
    ".GlobalPreferences" = {
      "com.apple.mouse.scaling" = 1.0;
      "com.apple.sound.beep.sound" = "/System/Library/Sounds/Ping.aiff";
    };

    dock = {
      autohide = true;
      autohide-time-modifier = 0.0;
      largesize = 48;
      magnification = true;
      mineffect = "scale";
      minimize-to-application = true;
      mru-spaces = true;
      orientation = "bottom";
      show-recents = false;

      persistent-apps = [
        "/Applications/Obsidian.app"
        "/Applications/Zen.app"
        "/Applications/Google\ Chrome\ Dev.app"
        "/Applications/Spotify.app"
        "/System/Applications/Mail.app"
        "/System/Applications/Calendar.app"
        "/Applications/Ghostty.app"
        "/Applications/Visual\ Studio\ Code.app"
        "/Applications/Xcode.app"
        "/Applications/Slack.app"
        "/Applications/WhatsApp.app"
        "/Applications/Microsoft\ Teams.app"
        "/Applications/Telegram.app"
        "/Applications/Discord.app"
        "/Applications/1Password.app"
        "/Applications/reMarkable.app"
        "/Applications/Windows\ App.app"
        "/Applications/Cisco/Cisco\ Secure\ Client.app"
        "/Applications/Ivanti\ Secure\ Access.app"
      ];

      persistent-others = [
        "/Users/${userId}"
      ];
    };

    finder = {
      _FXShowPosixPathInTitle = true;
      _FXSortFoldersFirst = true;
      AppleShowAllFiles = true;
      FXDefaultSearchScope = "SCcf";
      FXPreferredViewStyle = "Nlsv";
      ShowPathbar = true;
      ShowStatusBar = true;
    };

    loginwindow = {
      DisableConsoleAccess = true;
      GuestEnabled = false;
    };

    magicmouse = {
      MouseButtonMode = "TwoButton";
    };

    menuExtraClock = {
      Show24Hour = true;
    };

    NSGlobalDomain = {
      AppleEnableMouseSwipeNavigateWithScrolls = true;
      AppleICUForce24HourTime = true;
      AppleInterfaceStyle = "Dark";
      AppleMeasurementUnits = "Centimeters";
      AppleMetricUnits = 1;
      AppleScrollerPagingBehavior = true;
      AppleShowAllFiles = true;
      AppleShowScrollBars = "WhenScrolling";
      AppleTemperatureUnit = "Celsius";
      NSAutomaticCapitalizationEnabled = false;
      NSAutomaticInlinePredictionEnabled = false;
      NSAutomaticPeriodSubstitutionEnabled = false;
      NSAutomaticQuoteSubstitutionEnabled = false;
      NSAutomaticSpellingCorrectionEnabled = false;
      NSTableViewDefaultSizeMode = 1;
    };

    screencapture = {
      location = "~/Pictures";
      show-thumbnail = false;
      type = "jpg";
    };

    trackpad = {
      Clicking = true;
    };

    universalaccess = {
      reduceMotion = true;
    };

    WindowManager = {
      GloballyEnabled = true;
      StageManagerHideWidgets = true;
    };
  };

  users.users."${userId}" = {
    name = userId;
    home = "/Users/${userId}";
    shell = pkgs.zsh;
  };
}
