{ config, lib, pkgs, ... }:

with lib;

{
    programs.starship = {
        enableZshIntegration = true;

        settings = {
            git_commit.tag_symbol = " tag ";

            character = {
                success_symbol = "[>](bold green)";
                error_symbol = "[x](bold red)";
                vimcmd_symbol = "[<](bold green)";
            };

            custom = {
                devbox = {
                    when = "test \"$DEVBOX_SHELL_ENABLED\" = \"1\"";
                    format = "[in devbox](yellow)";
                };
            };

            format = concatStrings [
                "$directory"
                "$git_branch"
                "$git_status"
                "\${custom.devbox}"
                "$cmd_duration"
                "$line_break"
                "$character"
            ];

            git_branch = {
                format = "[$branch]($style) ";
                style = "purple";
            };

            git_status = {
                ahead = ">";
                behind = "<";
                diverged = "<>";
                renamed = "r";
                deleted = "x";
            };
        };
    };
}

