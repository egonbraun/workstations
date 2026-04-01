{
  description = "Workstation";

  inputs = {
    neovim-nightly-overlay.url = "github:nix-community/neovim-nightly-overlay";
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-24.11-darwin";

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
    nixpkgs,
    home-manager,
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
