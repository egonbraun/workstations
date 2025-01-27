{
  config,
  lib,
  pkgs,
  ...
}: {
  imports = [
    ./btop.nix
    ./direnv.nix
    ./fd.nix
    ./git.nix
    ./kitty.nix
    ./lsd.nix
    ./neovim.nix
    ./ssh.nix
    ./starship.nix
    ./zsh.nix
  ];
}
