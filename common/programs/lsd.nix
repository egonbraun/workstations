{
  config,
  lib,
  pkgs,
  ...
}: {
  programs.lsd = {
    enableAliases = true;
  };
}
