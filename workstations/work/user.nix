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

    ".local/bin/ec2conn" = {
      executable = true;
      source = ../../files/scripts/ec2conn;
    };
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
    pipenv
    poetry
    sqlfluff
    sshuttle
    tenv
    uv
  ];

  home.shellAliases = {
    "dig" = "dig +search +noall +answer +question";
    "dig-all" = "dig +all";
  };

  home.sessionPath = [
    "$HOME/.local/bin"
    "$HOME/.goenv/bin"
    "$HOME/go/1.24.1/bin"
    ".git/safe/../../bin"
    ".venv/bin"
    "/Applications/Visual Studio Code.app/Contents/Resources/app/bin"
  ];

  home.sessionVariables = {
    DEVBOX_NO_PROMPT = 1;
    EDITOR = "vim";
    GOENV_ROOT = "$HOME/.goenv";
    GOPATH = "$HOME/SourceCode";
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
    pyenv.enable = true;
    ripgrep.enable = true;
    ssh.enable = true;
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
          };
        }
        {
          condition = "gitdir:~/SourceCode/gitlab.com/devolksbank/";
          contents = {
            user = {
              name = userName;
              email = "egon.braun@devolksbank.nl";
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

    ssh = {
      matchBlocks = {
        aws-ssm-hosts = {
          host = "i-* mi-*";
          proxyCommand = "sh -c \"aws ssm start-session --target %h --document-name AWS-StartSSHSession --parameters 'portNumber=%p'\"";
        };
      };
    };
  };

  services = {
  };
}
