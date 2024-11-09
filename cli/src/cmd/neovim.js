import { program } from 'commander'
import { dotfilesDir } from '../lib/paths.js'
import path from 'node:path'
import fs from 'node:fs/promises'
import { logger } from '../lib/logging.js'
import { copyDirContents } from '../lib/fsutils.js'

export const neovimCommands = () => {
  const repoDir = path.join(dotfilesDir, 'neovim')
  const systemDir = path.join(process.env['HOME'], '.config', 'nvim')
  const systemLuaDir = path.join(systemDir, 'lua')
  const repoLuaDir = path.join(repoDir, 'lua')
  const systemInitLua = path.join(systemDir, 'init.lua')
  const repoInitLua = path.join(repoDir, 'init.lua')

  const neovim = program.command('neovim')

  neovim.command('save')
    .action(async () => {
      logger.info({ dir: repoDir }, 'cleaning')
      await fs.rm(repoDir, { recursive: true, force: true })
      logger.info({ from: systemDir, to: repoDir }, 'saving')
      await copyDirContents(systemLuaDir, repoLuaDir)
      await fs.copyFile(systemInitLua, repoInitLua)
      logger.info({ from: systemDir, to: repoDir }, 'done')
    })

  neovim.command('load')
    .action(async () => {
      logger.info({ dir: systemLuaDir }, 'cleaning')
      await fs.rm(systemLuaDir, { recursive: true, force: true })
      await copyDirContents(repoLuaDir, systemLuaDir)
      await fs.copyFile(repoInitLua, systemInitLua)
      logger.info({ from: repoDir, to: systemDir }, 'done')
    })
}