import path from "node:path";
import fs from "node:fs/promises";
import type { Environment, MakeEnvironmentCommandsFunc, CommandsPerEnvironment } from "@/lib/environment";
import { dotfilesDir, homeDir } from "@/lib/paths";
import { logger } from "@/lib/logging";

export const makeGhosttyCommands: MakeEnvironmentCommandsFunc = (commandsPerEnvironment: CommandsPerEnvironment) => {
  const systemDir = path.join(homeDir, ".config", "ghostty");
  const systemConfig = path.join(systemDir, "config");
  const validEnvs: Environment[] = ["macos", "linux"];
  for (const env of validEnvs) {
    const repoDir = path.join(dotfilesDir, env, "ghostty");
    const repoConfig = path.join(repoDir, "config");

    const ghostty = commandsPerEnvironment[env].command("ghostty");

    ghostty.command("save").action(async () => {
      logger.info({ from: systemConfig, to: repoConfig }, "saving ghostty config");
      await fs.mkdir(repoDir, { recursive: true });
      await fs.copyFile(systemConfig, repoConfig);
    });

    ghostty.command("load").action(async () => {
      logger.info({ from: repoConfig, to: systemConfig }, "loading ghostty config");
      await fs.mkdir(systemDir, { recursive: true });
      await fs.copyFile(repoConfig, systemConfig);
    });
  }
};
