import path from "node:path";
import { dotfilesDir, homeDir } from "@/lib/paths";
import { logger } from "@/lib/logging";
import fs from "node:fs/promises";
import type { CommandsPerEnvironment, MakeEnvironmentCommandsFunc } from "@/lib/environment";

export const makeStarshipCommands: MakeEnvironmentCommandsFunc = (commandsPerEnvironment: CommandsPerEnvironment) => {
  const repoDir = path.join(dotfilesDir, "shared", "starship");
  const repoConfig = path.join(repoDir, "starship.toml");
  const systemConfig = path.join(homeDir, ".config", "starship.toml");

  const starship = commandsPerEnvironment["shared"].command("starship");

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
