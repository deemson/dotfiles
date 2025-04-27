import { program } from "commander";
import { logger } from "../lib/logging.ts";
import fs from "node:fs/promises";
import path from "node:path";
import { dotfilesDir, homeDir } from "../lib/paths.ts";

export const binscriptsCommands = () => {
  const repoDir = path.join(dotfilesDir, "binscripts");
  const systemDir = path.join(homeDir, ".bin");
  const filePaths = ["dotfiles", "dotfiles-save", "dotfiles-load"].map(
    (fileName) => ({
      repo: path.join(repoDir, fileName),
      system: path.join(systemDir, fileName),
    }),
  );

  const binScripts = program.command("binscripts");

  binScripts.command("save").action(async () => {
    logger.info({ dir: repoDir }, "cleaning");
    await fs.rm(repoDir, { recursive: true, force: true });
    await fs.mkdir(repoDir, { recursive: true });
    for (const filePath of filePaths) {
      logger.info({ from: filePath.system, to: filePath.repo }, "saving");
      await fs.copyFile(filePath.system, filePath.repo);
    }
    logger.info({ from: systemDir, to: repoDir }, "done");
  });

  binScripts.command("load").action(async () => {
    await fs.mkdir(systemDir, { recursive: true });
    for (const filePath of filePaths) {
      logger.info({ from: filePath.repo, to: filePath.system }, "loading");
      await fs.copyFile(filePath.repo, filePath.system);
    }
    logger.info({ from: repoDir, to: systemDir }, "done");
  });
};

