{ config, lib, pkgs, ... }:
{
    programs.vscode = {
        extensions = with pkgs.vscode-extensions; [
        ];

        userSettings = {
        };
    };
}

