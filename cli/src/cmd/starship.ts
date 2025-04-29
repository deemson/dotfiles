import path from "node:path";
import { dotfilesDir, homeDir } from "../lib/paths.ts";
import { program } from "commander";
import { logger } from "../lib/logging.ts";
import fs from "node:fs/promises";

export const starshipCommands = () => {
  const repoDir = path.join(dotfilesDir, "starship");
  const repoConfig = path.join(repoDir, "starship.toml");
  const systemConfig = path.join(homeDir, ".config", "starship.toml");

  const starship = program.command("starship");

  starship.command("save").action(async () => {
    logger.info({ from: systemConfig, to: repoConfig }, "saving starship config");
    await fs.mkdir(repoDir, { recursive: true });
    await fs.copyFile(systemConfig, repoConfig);
  });

  starship.command("load").action(async () => {
    logger.info({ from: repoConfig, to: systemConfig }, "loading starship config");
    await fs.copyFile(repoConfig, systemConfig);
  });
};
