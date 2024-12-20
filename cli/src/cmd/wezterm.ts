import { program } from 'commander'
import { dotfilesDir, homeDir } from '../lib/paths.ts'
import path from 'node:path'
import fs from 'node:fs/promises'
import { logger } from '../lib/logging.ts'

export const weztermCommands = () => {
  const repoDir = path.join(dotfilesDir, 'wezterm')
  const repoConfig = path.join(repoDir, 'wezterm.lua')
  const systemConfig = path.join(homeDir, '.wezterm.lua')

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
      logger.info({ from: repoConfig, to: systemConfig }, 'loading')
      await fs.copyFile(repoConfig, systemConfig)
      logger.info({ from: repoConfig, to: systemConfig }, 'done')
    })
}