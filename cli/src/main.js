import { program } from 'commander'
import { neovimCommands } from './cmd/neovim.js'
import { starshipCommands } from './cmd/sharship.js'

neovimCommands()
starshipCommands()
program.parse()