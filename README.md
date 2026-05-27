# dotfiles

Hey. These are my [personal](https://github.com/deemson) dotfiles, managed with a custom CLI.

## Overview

This repository stores configuration files for shell, editor, terminal, and desktop tools across macOS and Linux. A TypeScript/Bun CLI handles syncing configs between the system and the repo — in both directions.

## CLI

The `dotfiles` command (available after loading the shell config) lets you:

- **Load** — copy configs from the repo onto the system
- **Save** — capture current system configs back into the repo
- **Manage apps** — perform app-specific setup tasks

Both load and save support a dry-run mode to preview changes before applying them.

## Configuration profiles

Configs are split into environment profiles and reusable app configs. Environment profiles use inheritance:

```
base-posix  (abstract — macOS + Linux)
├── macos
└── base-linux  (abstract)
    └── nixos
```

Each environment profile declares the app configs it manages, such as `posix/zsh` or `macos/hammerspoon`. App configs live under `config/apps/` and define where each app's files live on disk. This keeps shared app definitions reusable while preserving platform-specific overrides.

## Repository layout

```
.dotfiles/
├── cli/          # TypeScript CLI source
├── config/       # Environment profiles and app definitions (YAML)
│   ├── envs/
│   └── apps/
├── dotfiles/     # Actual config files, organized by platform
│   ├── posix/
│   ├── macos/
│   └── linux/
└── colors/       # Shared color scheme assets
```

## Prerequisites

- [mise](https://mise.jdx.dev) — installs and manages tool versions, including Bun (used to run CLI)
