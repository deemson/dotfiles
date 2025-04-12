# deemson dotfiles

Hey. These are my dotfiles (configuration files for the apps I use).

Structure (non-exhaustive):

- [/cli](./cli) contains a simple CLI written in TypeScript to manage the dotfiles.
To run you need to have [bun](https://bun.sh/) installed. If it is, then it's as simple as `bun ./cli/src/main.ts`. Follow the help provided.
But in general, commands are per-app and usually each app's command at the very minimum
contains `save`/`load` subcommands to manage the relevant config files.
- [/dotfiles](./dotfiles) the actual dotfiles. You may either use them directly or use the CLI tool mentioned above.
