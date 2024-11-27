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
  };
}
