{ config, lib, pkgs, specialArgs, ... }:

let
    userEmail = specialArgs.systemParams.user.email;
    userName = specialArgs.systemParams.user.name;
in {
    programs.git = {
        enable = true;
        userEmail = userEmail;
        userName = userName;

        aliases = {
            prune = "fetch --prune --prune-tags";
            undo = "reset --soft HEAD^";
            stash-all = "stash save --include-untracked";
        };

        delta = {
            enable = true;
            options = {
                features = "side-by-side line-numbers decorations";
                whitespace-error-style = "reverse";

                decorations = {
                    commit-decoration-style = "bold yellow box ul";
                    file-decoration-style = "none";
                    file-style = "bold yellow ul";
                };
            };
        };

        extraConfig = {
            color.ui = "auto";
            core.autocrlf = "input";
            fetch.prune = true;
            init.defaultBranch = "main";
            pull.ff = "only";
            rebase.autosquash = true;
            status.showUntrackedFiles =  "all";
            transfer.fsckobjects = true;

            merge = {
                ff = "only";
                conflictstyle = "diff3";
            };

            push = {
                default = "simple";
                followTags = true;
            };
        };

        ignores = [
            "*~"
            "*.swp"
            ".DS_Store"
            ".apdisk"
            ".AppleDB"
            ".AppleDesktop"
            ".AppleDouble"
            ".com.apple.timemachine.donotpresent"
            ".DocumentRevisions-V100"
            ".DS_Store"
            ".fseventsd"
            ".LSOverride"
            ".Spotlight-V100"
            ".TemporaryItems"
            ".Trashes"
            ".VolumeIcon.icns"
            "*.icloud"
            "Icon"
            "Network Trash Folder"
            "Temporary Items"
        ];

        signing = {
            key = null;
            signByDefault = true;
        };
    };
}
