{
  config,
  lib,
  pkgs,
  ...
}:
with lib; {
  programs.starship = {
    enableZshIntegration = true;

    settings = {
      git_commit.tag_symbol = " tag ";

      character = {
        success_symbol = "[>](bold green)";
        error_symbol = "[x](bold red)";
        vimcmd_symbol = "[>](bold blue)";
      };

      custom = {
        devbox = {
          when = "test -n \"$DEVENV_ROOT\"";
          format = "[in devenv](yellow)";
        };
      };

      format = concatStrings [
        "$directory"
        "$git_branch"
        "$git_status"
        "\${custom.devbox}"
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
