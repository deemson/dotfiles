import path from 'node:path'

export const libDir = path.resolve(import.meta.dirname)
export const srcDir = path.dirname(libDir)
export const cliDir = path.dirname(srcDir)
export const topDir = path.dirname(cliDir)
export const dotfilesDir = path.join(topDir, 'dotfiles')