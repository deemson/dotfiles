import { program } from 'commander'
import { dotfilesDir } from '../lib/paths.js'
import path from 'node:path'
import fs from 'node:fs/promises'
import { logger } from '../lib/logging.js'
import { copyDirContents } from '../lib/fsutils.js'

export const weztermCommands = () => {
  const repoDir = path.join(dotfilesDir, 'wezterm')
  const repoConfig = path.join(repoDir, 'wezterm.lua')
  const systemConfig = path.join(process.env['HOME'], '.wezterm.lua')

  const wezterm = program.command('wezterm')

  wezterm.command('save')
    .action(async () => {
      logger.info({ from: systemConfig, to: repoConfig }, 'saving')
      await fs.mkdir(repoDir, { recursive: true })
      await fs.copyFile(systemConfig, repoConfig)
      logger.info({ from: systemConfig, to: repoConfig }, 'done')
    })

  wezterm.command('load')
    .action(async () => {
    })
}