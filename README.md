# Workstations

My workstations configuration using [nix](https://nixos.org/), [nix-darwin](https://github.com/LnL7/nix-darwin)
and [home-manager](https://github.com/nix-community/home-manager).

## Project Structure

- `common/`: lib modules that can be imported from the workstation configuration
- `files/`: files that are not nix source
- `secrets/`: workstation argument files
- `workstations/`: per workstation nix configuration
- `flake.nix`: the nix flake definition file

So, to add a new workstation we just need to add a new argument file, let's
call it `secrets/example.args.nix` using this template:

```nix
{
  # The name of the workstation, this is just used so you don't need to expose
  # your real hostname. This is the name the configuration will use to refer
  # to file names and other properties.
  name = "example";

  # Any extra modules you need to load as part of your worstation setup. You can
  # put these modules under the common directory.
  extraModules = [];

  system = {
    hostName = "host.example.com";  # Your real hostname
    platform = "x86-64";            # The platform of the host
  };

  user = {
    email = "me@example.com";       # Your e-mail (for git, ssh, etc...)
    id = "john.doe";                # Your real user ID in the host
    language = "en_US.utf-8";       # Your preferred language
    name = "John Doe";              # Your user display name
    timezone = "Europe/Amsterdam";  # Your local timezone
  };
}
```

Then create a sub-directory under `workstations/` for your configuration, for
example `workstations/example/`. Add two files under this directory, one called
`os.nix` which will contain the `nix-darwin` related configuration, and another
one called `user.nix` which will contain the `home-manager` configuration.

Populate these files with the configuration you need and deploy your
workstation using the tasks below.

## Tasks

This project uses [Task](https://taskfile.dev/) as a project task runner.

### Lint

Lints and formats the nix source code using [alejandra](https://github.com/kamadorueda/alejandra).

```sh
task lint
```

### Build

Only builds the configuration.

```sh
task build WORKSTATION=name
```

### Deploy

Deploy the configuration to your workstation.

```sh
task deploy WORKSTATION=name
```

### Release

Release a new version of the project to GitHub using the [gh](https://cli.github.com/) tool.

```sh
task release
```

## Env

You can also create a `.env` file containing the value of the WORKSTATION
variable, like this:

```
WORKSTATION=example
```

This way you can run the `deploy` task without needing to specify
the `WORKSTATION` variable all the time.

## git-crypt

As you might have guessed, the files under the `secrets/` are encrypted so we
don't leak any sensitive data. We achieve that by means of [git-crypt](https://github.com/AGWA/git-crypt).
Please, make sure you have it installed so the encryption process works.

## License

This project is licensed under the [GNU General Public License Version 3](https://github.com/egonbraun/workstations/blob/main/LICENSE).
