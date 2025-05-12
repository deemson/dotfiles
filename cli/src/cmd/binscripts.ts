import { logger } from "@/lib/logging";
import fs from "node:fs/promises";
import path from "node:path";
import { dotfilesDir, homeDir } from "@/lib/paths";
import type { Environment, MakeEnvironmentCommandsFunc, CommandsPerEnvironment } from "@/lib/environment";

export const makeBinscriptsCommands: MakeEnvironmentCommandsFunc = (commandsPerEnvironment: CommandsPerEnvironment) => {
  const systemDir = path.join(homeDir, ".bin");
  const validEnvs: Environment[] = ["macos", "linux"];
  const repoSharedDir = path.join(dotfilesDir, "shared", "binscripts");
  const sharedFilePaths = ["dotfiles"].map((fileName) => ({
    repo: path.join(repoSharedDir, fileName),
    system: path.join(systemDir, fileName),
  }));

  for (const env of validEnvs) {
    const binScripts = commandsPerEnvironment[env].command("binscripts");
    const repoEnvDir = path.join(dotfilesDir, env, "binscripts");
    const envFilePaths = ["dotfiles-save", "dotfiles-load"].map((fileName) => ({
      repo: path.join(repoEnvDir, fileName),
      system: path.join(systemDir, fileName),
    }));

    binScripts.command("save").action(async () => {
      logger.info({ dir: repoSharedDir }, "cleaning repo shared binscripts dir");
      await fs.rm(repoSharedDir, { recursive: true, force: true });
      await fs.mkdir(repoSharedDir, { recursive: true });
      for (const filePath of sharedFilePaths) {
        logger.info({ from: filePath.system, to: filePath.repo }, "saving shared binscript");
        await fs.copyFile(filePath.system, filePath.repo);
      }
      logger.info({ dir: repoEnvDir }, "cleaning repo env binscripts dir");
      await fs.rm(repoEnvDir, { recursive: true, force: true });
      await fs.mkdir(repoEnvDir, { recursive: true });
      for (const filePath of envFilePaths) {
        logger.info({ from: filePath.system, to: filePath.repo }, "saving env binscript");
        await fs.copyFile(filePath.system, filePath.repo);
      }
    });

    binScripts.command("load").action(async () => {
      await fs.mkdir(systemDir, { recursive: true });
      for (const filePath of sharedFilePaths) {
        logger.info({ from: filePath.repo, to: filePath.system }, "loading shared binscript");
        await fs.copyFile(filePath.repo, filePath.system);
      }
      for (const filePath of envFilePaths) {
        logger.info({ from: filePath.repo, to: filePath.system }, "loading env binscript");
        await fs.copyFile(filePath.repo, filePath.system);
      }
    });
  }
};
