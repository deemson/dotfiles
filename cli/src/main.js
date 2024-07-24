import { program } from 'commander'
import { neovimCommands } from './cmd/neovim.js'

neovimCommands()
program.parse()