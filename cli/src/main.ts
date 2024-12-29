import { program } from 'commander'
import { binscriptsCommands } from './cmd/binscripts.ts'
import { neovimCommands } from './cmd/neovim.ts'
import { starshipCommands } from './cmd/starship.ts'
import { zshCommands } from './cmd/zsh.ts'
import { weztermCommands } from './cmd/wezterm.ts'
import { ghosttyCommands } from './cmd/ghostty.ts'

binscriptsCommands()
neovimCommands()
starshipCommands()
zshCommands()
weztermCommands()
ghosttyCommands()
program.parse()