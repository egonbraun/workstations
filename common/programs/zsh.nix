{
  config,
  lib,
  pkgs,
  ...
}: {
  programs.zsh = {
    autocd = true;
    autosuggestion.enable = true;
    enableCompletion = true;
    syntaxHighlighting.enable = true;

    initExtra = ''
      eval "$(/opt/homebrew/bin/brew shellenv)"
      eval "$(goenv init -)"
    '';
  };
}
