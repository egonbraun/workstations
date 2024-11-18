{ config, lib, pkgs, specialArgs, ... }:
let
    params = specialArgs.systemParams;
    systemRole = params.system.role;
    userId = params.user.id;
in
{
    imports = [
        ../../common/programs
        ../../users/${ userId }/user.nix
    ];

    manual.manpages.enable = true;

    home.file = {
        ".hushlogin".text = "";
    };

    home.packages = with pkgs; [
        colima
        docker-client
        git-crypt
    ];

    home.shellAliases = {
        "dig" = "dig +search +noall +answer +question";
        "dig-all" = "dig +all";
    };

    home.sessionPath = [
        ".git/safe/../../bin"
    ];

    home.sessionVariables = {
        EDITOR = "vim";
        HOMEBREW_NO_ANALYTICS = 1;
        HOMEBREW_NO_ENV_HINTS = 1;
    };

    programs = {
        btop.enable = true;
        bat.enable = true;
        direnv.enable = true;
        fd.enable = true;
        fzf.enable = true;
        git.enable = true;
        home-manager.enable = true;
        jq.enable = true;
        lazygit.enable = true;
        lsd.enable = true;
        neovim.enable = true;
        ripgrep.enable = true;
        starship.enable = true;
        zoxide.enable = true;
        zsh.enable = true;
        wezterm.enable = true;
    };

    services = {
    };
}
