import path from "node:path";
import { dotfilesDir, homeDir } from "@/lib/paths";
import { logger } from "@/lib/logging";
import fs from "node:fs/promises";
import type { CommandsPerEnvironment, MakeEnvironmentCommandsFunc } from "@/lib/environment";

export const makeMiseCommands: MakeEnvironmentCommandsFunc = (commandsPerEnvironment: CommandsPerEnvironment) => {
  const repoDir = path.join(dotfilesDir, "shared", "mise");
  const repoConfig = path.join(repoDir, "config.toml");
  const systemConfig = path.join(homeDir, ".config", "mise", "config.toml");

  const mise = commandsPerEnvironment["shared"].command("mise");

  mise.command("save").action(async () => {
    logger.info({ from: systemConfig, to: repoConfig }, "saving mise config");
    await fs.mkdir(repoDir, { recursive: true });
    await fs.copyFile(systemConfig, repoConfig);
  });

  mise.command("load").action(async () => {
    logger.info({ from: repoConfig, to: systemConfig }, "loading mise config");
    await fs.copyFile(repoConfig, systemConfig);
  });
};
