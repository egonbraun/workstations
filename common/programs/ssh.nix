{
  config,
  lib,
  pkgs,
  ...
}: {
  programs.ssh = {
    extraConfig = ''
      ${builtins.readFile ../../files/ssh/config}
    '';;
  };
}
