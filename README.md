# Workstations

My workstations configuration using [nix](https://nixos.org/), [nix-darwin](https://github.com/LnL7/nix-darwin)
and [home-manager](https://github.com/nix-community/home-manager).

## Project Structure

- common: lib modules that can be imported from the workstation configuration
- files: files that are not nix source
- secrets: workstation argument files
- workstations: per workstation nix configuration

So, to add a new workstation we just need to add a new argument file following
this template:

```nix
# File: secrets/example.args.nix
{
  name = "example";

  extraModules = [];

  system = {
    hostName = "host.example.com";
    platform = "x86-64";
  };

  user = {
    email = "me@example.com";
    id = "john.doe";
    language = "en_US.utf-8";
    name = "John Doe";
    timezone = "Europe/Amsterdam";
  };
}
```

Then create a sub-directory under `workstations` for your configuration, for
example `workstations/example`. Add two files under this directory, one called
`os.nix` which will contain the `nix-darwin` related configuration, and another
one called `user.nix` which will contain the `home-manager` configuration.

## Tasks

### Lint

```sh
task lint
```

### Deploy

```sh
task deploy WORKSTATION=name
```

## Env

You can also create a `.env` file containing the value of the WORKSTATION
variable, like this:

```
# File: .env
WORKSTATION=example
```

This way you can run the `deploy` task without needing to specify
the `WORKSTATION` variable all the time.
