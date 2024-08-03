import { program } from 'commander'
import { neovimCommands } from './cmd/neovim.js'
import { starshipCommands } from './cmd/sharship.js'
import { zshCommands } from './cmd/zsh.js'

neovimCommands()
starshipCommands()
zshCommands()
program.parse()