# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

This is a Nix-based macOS workstation configuration system using nix-darwin and home-manager for declarative, reproducible machine setup. It manages two workstations: `personal` and `work`.

## Commands

All tasks use [Task](https://taskfile.dev) as the runner:

```sh
task lint                           # Lint and format all Nix files with alejandra
task build WORKSTATION=personal     # Build the flake without applying it
task deploy WORKSTATION=personal    # Apply configuration via nix-darwin switch (requires sudo)
task release TAG=vX.Y.Z             # Create a GitHub release
```

The `WORKSTATION` variable defaults to `personal` (set in `.env`).

## Architecture

### Entry Point

`flake.nix` is the main configuration. It defines a `mkMacWorkstation` helper that composes:
- `nix-darwin` for OS-level macOS settings
- `home-manager` for user-level dotfiles/program configs

It produces `darwinConfigurations` for both workstations using nixpkgs 24.11-darwin.

### Directory Layout

- `workstations/<name>/os.nix` — macOS system settings (dock, finder, fonts, system defaults)
- `workstations/<name>/user.nix` — home-manager config (enabled programs, env vars, git identity)
- `common/programs/` — reusable program modules (btop, direnv, fd, git, lsd, neovim, ssh, starship, zsh) imported by each workstation's `user.nix`
- `files/` — non-Nix config files (ghostty terminal config, neovim lua configs, utility scripts)
- `secrets/` — git-crypt encrypted `.args.nix` files containing per-workstation arguments (usernames, email, etc.)
- `Brewfile` — Homebrew casks and VS Code extensions managed separately from Nix

### Secrets

The `secrets/` directory is encrypted with git-crypt. Files follow the pattern `<workstation>.args.nix` and are passed as `extraArgs` into the workstation configuration.

### Adding a New Workstation

1. Create `secrets/<name>.args.nix` with required arguments
2. Create `workstations/<name>/os.nix` and `workstations/<name>/user.nix`
3. Add a `darwinConfigurations` entry in `flake.nix` using `mkMacWorkstation`
