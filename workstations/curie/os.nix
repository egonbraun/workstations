{ config, inputs, lib, pkgs, specialArgs, ... }:
let
    params = specialArgs.systemParams;
    extraApps = params.system.extraApps;
    extraCasks = params.system.extraCasks;
    hostName = params.system.hostName;
    platform = params.system.platform;
    systemRole = params.system.role;
    userId = params.user.id;
in
{
    imports = [
        ../../users/${ userId }/os.nix
    ];

    environment.shells = with pkgs; [ zsh ];
    networking.computerName = hostName;

    fonts = {
        packages = with pkgs; [
            (nerdfonts.override { fonts = [ "InconsolataLGC" ]; })
        ];
    };

    homebrew = {
        enable = true;

        casks = [
            "arc"
            "bartender"
            "google-chrome@dev"
            "gpg-suite-no-mail"
            "logi-options+"
            "session-manager-plugin"
            "zen-browser"
        ] ++ extraCasks;

        masApps = {
            "Affinity Designer 2" = 1616831348;
            "HotKey App" = 975890633;
            "System Color Picker" = 1545870783;
            "Xcode" = 497799835;
            "Logic Pro" = 634148309;
        } // extraApps;
    };
}

