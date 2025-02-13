{
  config,
  lib,
  pkgs,
  ...
}: {
  programs.pyenv = {
    enableZshIntegration = true;
  };
}
