import { program } from 'commander'
import { binscriptsCommands } from './cmd/binscripts.ts'
import { neovimCommands } from './cmd/neovim.ts'
import { starshipCommands } from './cmd/starship.ts'
import { zshCommands } from './cmd/zsh.ts'
import { weztermCommands } from './cmd/wezterm.ts'

binscriptsCommands()
neovimCommands()
starshipCommands()
zshCommands()
weztermCommands()
program.parse()