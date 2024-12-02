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
    devbox
    colima
    docker-client
    gh
    git-crypt
    go-task
  ];

  home.shellAliases = {
    "dig" = "dig +search +noall +answer +question";
    "dig-all" = "dig +all";
  };

  home.sessionPath = [
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
    lazygit.enable = true;
    lsd.enable = true;
    neovim.enable = true;
    ripgrep.enable = true;
    starship.enable = true;
    zoxide.enable = true;
    zsh.enable = true;
    wezterm.enable = true;

    git = {
      includes = [
        {
          condition = "gitdir:~/SourceCode/github.com/egonbraun/";
          contents = {
            user = {
              name = userName;
              email = "egon@mundoalem.io";
            };

            core = {
              sshCommand = "ssh -i ~/.ssh/ssh-personal-private-rsa";
            };
          };
        }
        {
          condition = "gitdir:~/SourceCode/github.com/mundoalem/";
          contents = {
            user = {
              name = userName;
              email = "egon@mundoalem.io";
            };

            core = {
              sshCommand = "ssh -i ~/.ssh/ssh-personal-private-rsa";
            };
          };
        }
        {
          condition = "gitdir:~/SourceCode/github.com/devolksbank-ep/";
          contents = {
            user = {
              name = userName;
              email = "egon.braun@devolksbank.nl";
            };

            core = {
              sshCommand = "ssh -i ~/.ssh/ssh-devolksbank-private-rsa";
            };
          };
        }
        {
          condition = "gitdir:~/SourceCode/gitlab.com/devolksbank/";
          contents = {
            user = {
              name = userName;
              email = "egon.braun@devolksbank.nl";
            };

            core = {
              sshCommand = "ssh -i ~/.ssh/ssh-schubergphilis-private-rsa";
            };
          };
        }
        {
          condition = "gitdir:~/SourceCode/github.com/sbpdvb/";
          contents = {
            user = {
              name = userName;
              email = userEmail;
            };

            core = {
              sshCommand = "ssh -i ~/.ssh/ssh-schubergphilis-private-rsa";
            };
          };
        }
        {
          condition = "gitdir:~/SourceCode/github.com/schubergphilis/";
          contents = {
            user = {
              name = userName;
              email = userEmail;
            };

            core = {
              sshCommand = "ssh -i ~/.ssh/ssh-schubergphilis-private-rsa";
            };
          };
        }
      ];
    };
  };

  services = {
  };
}
