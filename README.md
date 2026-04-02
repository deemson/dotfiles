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

Configs are organized into platform profiles that use inheritance:

```
posix  (base — macOS + Linux)
├── macos
└── linux
```

Each profile declares which applications it manages and where their config files live on disk. This makes it easy to share common config while keeping platform-specific overrides separate.

## Repository layout

```
.dotfiles/
├── cli/          # TypeScript CLI source
├── config/       # Platform profile definitions (YAML)
├── dotfiles/     # Actual config files, organized by platform
│   ├── posix/
│   ├── macos/
│   └── linux/
└── colors/       # Shared color scheme assets
```

## Prerequisites

- [mise](https://mise.jdx.dev) — installs and manages tool versions, including Bun (used to run CLI)
