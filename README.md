# deemson dotfiles

Hey. These are my dotfiles (configuration files for the apps I use).

Structure (non-exhaustive):

- [/cli](./cli) contains a simple node.js CLI to manage the dotfiles. Just do `npm install` and `node src/main.js` and
follow help provided. Commands are per-app and usually each app's command at the very minimum contains `save`/`load`
subcommands to manage the relevant config files
- [/dotfiles](./dotfiles) the actual dotfiles. You may either use them directly or use the CLI tool mentioned above.
