import { program } from "commander";
import { dotfilesDir, homeDir } from "../lib/paths.ts";
import path from "node:path";
import fs from "node:fs/promises";
import { logger } from "../lib/logging.ts";

export const ghosttyCommands = () => {
  const repoDir = path.join(dotfilesDir, "ghostty");
  const repoConfig = path.join(repoDir, "config");
  const systemDir = path.join(homeDir, ".config", "ghostty");
  const systemConfig = path.join(systemDir, "config");

  const ghostty = program.command("ghostty");

  ghostty.command("save").action(async () => {
    logger.info({ from: systemConfig, to: repoConfig }, "saving");
    await fs.mkdir(repoDir, { recursive: true });
    await fs.copyFile(systemConfig, repoConfig);
    logger.info({ from: systemConfig, to: repoConfig }, "done");
  });

  ghostty.command("load").action(async () => {
    logger.info({ from: repoConfig, to: systemConfig }, "loading");
    await fs.mkdir(systemDir, { recursive: true });
    await fs.copyFile(repoConfig, systemConfig);
    logger.info({ from: repoConfig, to: systemConfig }, "done");
  });
};

