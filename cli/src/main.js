import { program } from 'commander'
import { neovimCommands } from './cmd/neovim.js'
import { starshipCommands } from './cmd/sharship.js'
import { zshCommands } from './cmd/zsh.js'
import { weztermCommands } from './cmd/wezterm.js'

neovimCommands()
starshipCommands()
zshCommands()
weztermCommands()
program.parse()