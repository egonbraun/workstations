{
  description = "Workstation";

  inputs = {
    neovim-nightly-overlay.url = "github:nix-community/neovim-nightly-overlay";
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-24.11-darwin";
    nix-homebrew.url = "github:zhaofengli-wip/nix-homebrew";

    homebrew-bundle = {
      url = "github:homebrew/homebrew-bundle";
      flake = false;
    };

    homebrew-cask = {
      url = "github:homebrew/homebrew-cask";
      flake = false;
    };

    homebrew-core = {
      url = "github:homebrew/homebrew-core";
      flake = false;
    };

    home-manager = {
      url = "github:nix-community/home-manager/release-24.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-darwin = {
      url = "github:LnL7/nix-darwin/nix-darwin-24.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {
    self,
    nix-darwin,
    nix-homebrew,
    nixpkgs,
    home-manager,
    homebrew-bundle,
    homebrew-cask,
    homebrew-core,
    ...
  } @ inputs: let
    defaultConfiguration = {
      pkgs,
      specialArgs,
      ...
    } @ inputs: {
      nix.package = pkgs.nix;
      nix.settings.experimental-features = "nix-command flakes";
      nix.settings.trusted-users = ["root" specialArgs.workstationArgs.user.id];
      services.nix-daemon.enable = true;
      system.configurationRevision = self.rev or self.dirtyRev or null;
      system.stateVersion = 5;
    };

    personalArgs = import ./secrets/personal.args.nix;
    workArgs = import ./secrets/work.args.nix;

    mkMacWorkstation = args:
      nix-darwin.lib.darwinSystem {
        system = args.system.platform;

        specialArgs = {
          inherit inputs;
          workstationArgs = args;
        };

        modules =
          [
            defaultConfiguration

            ./workstations/${args.name}/os.nix

            home-manager.darwinModules.home-manager
            {
              home-manager = {
                backupFileExtension = "bkp";
                users."${args.user.id}" = import ./workstations/${args.name}/user.nix;

                extraSpecialArgs = {
                  inherit inputs;
                  workstationArgs = args;
                };
              };
            }

            nix-homebrew.darwinModules.nix-homebrew
            {
              nix-homebrew = {
                enable = true;
                autoMigrate = true;
                enableRosetta = true;
                mutableTaps = false;
                user = "${args.user.id}";

                taps = {
                  "homebrew/homebrew-bundle" = homebrew-bundle;
                  "homebrew/homebrew-core" = homebrew-core;
                  "homebrew/homebrew-cask" = homebrew-cask;
                };
              };
            }
          ]
          ++ args.extraModules;
      };
  in {
    darwinConfigurations = {
      "personal" = mkMacWorkstation personalArgs;
      "work" = mkMacWorkstation workArgs;
    };
  };
}
