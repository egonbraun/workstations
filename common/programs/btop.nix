{ config, lib, pkgs, ... }:
{
    programs.btop = {
        settings = {
            color_theme = "dracula";
            theme_background = false;
            truecolor = true;
            vim_keys = true;
        };
    };
}
