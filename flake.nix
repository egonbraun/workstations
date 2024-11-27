{
  description = "Workstation";

  inputs = {
    neovim-nightly-overlay.url = "github:nix-community/neovim-nightly-overlay";
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-24.05-darwin";
    nix-homebrew.url = "github:zhaofengli-wip/nix-homebrew";

    homebrew-cask = {
      url = "github:homebrew/homebrew-cask";
      flake = false;
    };

    homebrew-core = {
      url = "github:homebrew/homebrew-core";
      flake = false;
    };

    home-manager = {
      url = "github:nix-community/home-manager/release-24.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-darwin = {
      url = "github:LnL7/nix-darwin";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {
    self,
    nix-darwin,
    nix-homebrew,
    nixpkgs,
    home-manager,
    homebrew-cask,
    homebrew-core,
    ...
  } @ inputs: let
    # ----------------------------------------------------------------------
    # VARIABLES
    # ----------------------------------------------------------------------
    defaultConfiguration = {pkgs, ...} @ inputs: {
      nix.package = pkgs.nix;
      nix.settings.experimental-features = "nix-command flakes";
      services.nix-daemon.enable = true;
      system.configurationRevision = self.rev or self.dirtyRev or null;
      system.stateVersion = 5;
    };

    curieArgs = import ./secrets/curie.args.nix;

    # ----------------------------------------------------------------------
    # FUNCTIONS
    # ----------------------------------------------------------------------

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

            ./workstations/${args.system.hostName}/os.nix

            home-manager.darwinModules.home-manager
            {
              home-manager = {
                backupFileExtension = "bkp";
                users."${args.user.id}" = import ./workstations/${args.system.hostName}/user.nix;

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
                user = "${args.user.id}";

                taps = {
                  "homebrew/homebrew-core" = homebrew-core;
                  "homebrew/homebrew-cask" = homebrew-cask;
                };
              };
            }
          ]
          ++ args.extraModules;
      };
    # ----------------------------------------------------------------------
  in {
    # ----------------------------------------------------------------------
    # SYSTEMS
    # ----------------------------------------------------------------------

    darwinConfigurations = {
      "curie" = mkMacWorkstation curieArgs;
    };

    # ----------------------------------------------------------------------

    # TODO: Is this necessary? If yes, how to make it dynamic?
    darwinPackages = self.darwinConfigurations."curie".pkgs;
  };
}
