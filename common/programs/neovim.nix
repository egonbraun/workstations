{
  config,
  inputs,
  lib,
  pkgs,
  specialArgs,
  ...
}: let
  args = specialArgs.workstationArgs;
  systemPlatform = args.system.platform;
in {
  programs.neovim = {
    package = inputs.neovim-nightly-overlay.packages.${systemPlatform}.default;
    viAlias = true;
    vimAlias = true;
    vimdiffAlias = true;

    extraLuaConfig = ''
      ${builtins.readFile ../../files/neovim/init.lua}
    '';

    plugins = with pkgs.vimPlugins; [
    ];
  };
}
