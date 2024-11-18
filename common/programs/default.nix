{ config, lib, pkgs, ... }:
{
    imports = [
        ./btop.nix
        ./direnv.nix
        ./fd.nix
        ./git.nix
        ./lsd.nix
        ./neovim.nix
        ./starship.nix
        ./zsh.nix
        ./wezterm.nix
    ];
}
