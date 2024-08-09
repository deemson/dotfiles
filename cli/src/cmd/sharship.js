import path from 'node:path'
import { dotfilesDir } from '../lib/paths.js'
import { program } from 'commander'
import { logger } from '../lib/logging.js'
import fs from 'node:fs/promises'

export const starshipCommands = () => {
  const repoDir = path.join(dotfilesDir, 'starship')
  const repoConfig = path.join(repoDir, 'starship.toml')
  const systemConfig = path.join(process.env['HOME'], '.config', 'starship.toml')

  const starship = program.command('starship')

  starship.command('save')
    .action(async () => {
      logger.info({ from: systemConfig, to: repoConfig }, 'saving')
      await fs.mkdir(repoDir, { recursive: true })
      await fs.copyFile(systemConfig, repoConfig)
      logger.info({ from: systemConfig, to: repoConfig }, 'done')
    })

  starship.command('load')
    .action(async () => {
    })
}