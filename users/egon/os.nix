{ config, lib, pkgs, specialArgs, ... }:
let
    params = specialArgs.systemParams;
    userTimezone = params.user.timezone;
    userId = params.user.id;
in
{
    security.pam.enableSudoTouchIdAuth = true;
    time.timeZone = userTimezone;

    homebrew = {
        enable = true;

        casks = [
            "alfred"
            "discord"
            "elgato-control-center"
            "elgato-stream-deck"
            "figma"
            "loopback"
            "obs"
            "protonvpn"
            "protonmail-bridge"
            "rectangle-pro"
            "remarkable"
            "spotify"
            "telegram"
            "whatsapp"
        ];

        masApps = {
            "System Color Picker" = 1545870783;
            "Logic Pro" = 634148309;
            "HotKey App" = 975890633;
        };
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
            largesize = 32;
            magnification = true;
            mineffect = "scale";
            minimize-to-application = true;
            mru-spaces = true;
            orientation = "bottom";
            show-recents = false;

            persistent-apps = [
                "/Users/${ userId }/Applications/Home\ Manager\ Apps/WezTerm.app"
                "/System/Applications/Notes.app"
                "/System/Applications/Reminders.app"
                "/Applications/Zen\ Browser.app"
                "/Applications/Google\ Chrome\ Dev.app"
                "/System/Applications/Mail.app"
                "/System/Applications/Calendar.app"
                "/Applications/Xcode.app"
                "/Applications/Figma.app"
                "/Applications/Affinity Designer 2.app"
                "/Applications/OBS.app"
                "/Applications/Logic Pro.app"
                "/Applications/Spotify.app"
                "/Applications/WhatsApp.app"
                "/Applications/Telegram.app"
                "/Applications/Discord.app"
            ];

            persistent-others = [
                "/Users/${ userId }"
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

    users.users."${ userId }" = {
        name = userId;
        home = "/Users/${ userId }";
        shell = pkgs.zsh;
    };
}
