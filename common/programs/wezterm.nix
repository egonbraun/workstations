{
  config,
  lib,
  pkgs,
  ...
}: {
  programs.wezterm = {
    enableZshIntegration = true;

    extraConfig = ''
      ${builtins.readFile ../../files/wezterm/wezterm.lua}
    '';
  };
}
