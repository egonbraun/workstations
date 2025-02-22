{
  config,
  lib,
  pkgs,
  specialArgs,
  ...
}: let
  args = specialArgs.workstationArgs;
  systemRole = args.system.role;
  userEmail = args.user.email;
  userId = args.user.id;
  userLanguage = args.user.language;
  userName = args.user.name;
in {
  imports = [
    ../../common/programs
  ];

  manual.manpages.enable = true;

  home = {
    homeDirectory = "/Users/${userId}";
    language.base = userLanguage;
    stateVersion = "24.05";
    username = userId;
  };

  home.file = {
    ".hushlogin".text = "";

    ".aws/config".text = ''
      [default]
      region = eu-central-1
      output = json
    '';
  };

  home.packages = with pkgs; [
    alejandra
    awscli2
    azure-cli
    devbox
    colima
    docker-client
    gh
    git-crypt
    glab
    go-task
    sqlfluff
  ];

  home.shellAliases = {
    "dig" = "dig +search +noall +answer +question";
    "dig-all" = "dig +all";
  };

  home.sessionPath = [
    "/Applications/Visual Studio Code.app/Contents/Resources/app/bin"
    "$HOME/.local/bin"
    ".git/safe/../../bin"
    ".venv/bin"
  ];

  home.sessionVariables = {
    DEVBOX_NO_PROMPT = 1;
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
    kitty.enable = true;
    lazygit.enable = true;
    lsd.enable = true;
    neovim.enable = true;
    ripgrep.enable = true;
    starship.enable = true;
    zoxide.enable = true;
    zsh.enable = true;

    git = {
      includes = [
        {
          condition = "gitdir:~/SourceCode/github.com/egonbraun/";
          contents = {
            user = {
              name = userName;
              email = userEmail;
            };
          };
        }
        {
          condition = "gitdir:~/SourceCode/github.com/mundoalem/";
          contents = {
            user = {
              name = userName;
              email = userEmail;
            };
          };
        }
      ];
    };
  };

  services = {
  };
}
