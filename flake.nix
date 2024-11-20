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

        defaultConfiguration =
            { pkgs, ... }@inputs:
            {
                nix.package = pkgs.nix;
                nix.settings.experimental-features = "nix-command flakes";
                services.nix-daemon.enable = true;
                system.configurationRevision = self.rev or self.dirtyRev or null;
                system.stateVersion = 5;
            };

        curieHostArgs = import ./secrets/curie.args.nix;

        # ----------------------------------------------------------------------
        # FUNCTIONS
        # ----------------------------------------------------------------------

        mkMacWorkstation =
            params:
            nix-darwin.lib.darwinSystem {
                system = params.system.platform;

                specialArgs = {
                    inherit inputs;
                    systemParams = params;
                };

                modules = [
                    defaultConfiguration

                    ./workstations/${ params.system.hostName }/os.nix

                    home-manager.darwinModules.home-manager
                    {
                        home-manager = {
                            backupFileExtension = "bkp";
                            users."${ params.user.id }" = import ./workstations/${ params.system.hostName }/user.nix;

                            extraSpecialArgs = {
                                inherit inputs;
                                systemParams = params;
                            };
                        };
                    }

                    nix-homebrew.darwinModules.nix-homebrew
                    {
                        nix-homebrew = {
                            enable = true;
                            autoMigrate = true;
                            enableRosetta = true;
                            user = "${ params.user.id }";

                            taps = {
                                "homebrew/homebrew-core" = homebrew-core;
                                "homebrew/homebrew-cask" = homebrew-cask;
                            };
                        };
                    }
                ]
                ++ params.extraModules;
            };

        # ----------------------------------------------------------------------

    in {

        # ----------------------------------------------------------------------
        # SYSTEMS
        # ----------------------------------------------------------------------

        darwinConfigurations = {
            "curie" = mkMacWorkstation curieHostArgs;
        };

        # ----------------------------------------------------------------------

        # TODO: Is this necessary? If yes, how to make it dynamic?
        darwinPackages = self.darwinConfigurations."curie".pkgs;
    };
}
