import path from "node:path";
import fs from "node:fs/promises";
import type { MakeEnvironmentCommandsFunc, CommandsPerEnvironment } from "@/lib/environment";
import { copyDirContents } from "@/lib/fsutils";
import { dotfilesDir, homeDir } from "@/lib/paths";
import { logger } from "@/lib/logging";

export const makeWofiCommands: MakeEnvironmentCommandsFunc = (commandsPerEnvironment: CommandsPerEnvironment) => {
  const systemDir = path.join(homeDir, ".config", "wofi");
  const repoDir = path.join(dotfilesDir, "linux", "wofi");

  const wofi = commandsPerEnvironment["linux"].command("wofi");

  wofi.command("save").action(async () => {
    logger.info({ dir: repoDir }, "cleaning wofi repo dir");
    await fs.rm(repoDir, { recursive: true, force: true });
    logger.info({ from: systemDir, to: repoDir }, "saving wofi dir");
    await copyDirContents(systemDir, repoDir);
  });

  wofi.command("load").action(async () => {
    logger.info({ dir: systemDir }, "cleaning wofi system dir");
    await fs.rm(systemDir, { recursive: true, force: true });
    logger.info({ from: repoDir, to: systemDir }, "loading wofi dir");
    await fs.mkdir(systemDir, { recursive: true });
    await copyDirContents(repoDir, systemDir);
  });
};
