import path from "node:path";
import fs from "node:fs/promises";
import type { MakeEnvironmentCommandsFunc, CommandsPerEnvironment } from "@/lib/environment";
import { copyDirContents } from "@/lib/fsutils";
import { dotfilesDir, homeDir } from "@/lib/paths";
import { logger } from "@/lib/logging";

export const makeSwayCommands: MakeEnvironmentCommandsFunc = (commandsPerEnvironment: CommandsPerEnvironment) => {
  const systemDir = path.join(homeDir, ".config", "sway");
  const repoDir = path.join(dotfilesDir, "linux", "sway");

  const sway = commandsPerEnvironment["linux"].command("sway");

  sway.command("save").action(async () => {
    logger.info({ dir: repoDir }, "cleaning sway repo dir");
    await fs.rm(repoDir, { recursive: true, force: true });
    logger.info({ from: systemDir, to: repoDir }, "saving sway dir");
    await copyDirContents(systemDir, repoDir);
  });

  sway.command("load").action(async () => {
    logger.info({ dir: systemDir }, "cleaning sway system dir");
    await fs.rm(systemDir, { recursive: true, force: true });
    logger.info({ from: repoDir, to: systemDir }, "loading sway dir");
    await fs.mkdir(systemDir, { recursive: true });
    await copyDirContents(repoDir, systemDir);
  });
};
