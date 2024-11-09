import { program } from 'commander'
import { dotfilesDir } from '../lib/paths.js'
import path from 'node:path'
import fs from 'node:fs/promises'
import { logger } from '../lib/logging.js'
import { copyDirContents } from '../lib/fsutils.js'

export const zshCommands = () => {
  const repoDir = path.join(dotfilesDir, 'zsh')
  const homeDir = path.join(process.env['HOME'])
  const systemDotZshDir = path.join(homeDir, '.zsh')
  const repoDotZshDir = path.join(repoDir, 'dotzsh')
  const systemDotZshRC = path.join(homeDir, '.zshrc')
  const repoDotZshRC = path.join(repoDir, 'dotzsh.zsh')

  const zsh = program.command('zsh')

  zsh.command('save')
    .action(async () => {
      logger.info({ dir: repoDir }, 'cleaning')
      await fs.rm(repoDir, { recursive: true, force: true })
      logger.info({}, 'saving')
      await copyDirContents(systemDotZshDir, repoDotZshDir)
      await fs.copyFile(systemDotZshRC, repoDotZshRC)
      logger.info({}, 'done')
    })

  zsh.command('load')
    .action(async () => {
      logger.info({ dir: systemDotZshDir }, 'cleaning')
      await fs.rm(systemDotZshDir, { recursive: true, force: true })
      logger.info({}, 'loading')
      await copyDirContents(repoDotZshDir, systemDotZshDir)
      await fs.copyFile(repoDotZshRC, systemDotZshRC)
      logger.info({}, 'done')
    })
}