import path from "node:path";
import fs from "node:fs/promises";
import type { MakeEnvironmentCommandsFunc, CommandsPerEnvironment } from "@/lib/environment";
import { copyDirContents } from "@/lib/fsutils";
import { dotfilesDir, homeDir } from "@/lib/paths";
import { logger } from "@/lib/logging";

export const makeWaybarCommands: MakeEnvironmentCommandsFunc = (commandsPerEnvironment: CommandsPerEnvironment) => {
  const systemDir = path.join(homeDir, ".config", "waybar");
  const repoDir = path.join(dotfilesDir, "linux", "waybar");

  const waybar = commandsPerEnvironment["linux"].command("waybar");

  waybar.command("save").action(async () => {
    logger.info({ dir: repoDir }, "cleaning waybar repo dir");
    await fs.rm(repoDir, { recursive: true, force: true });
    logger.info({ from: systemDir, to: repoDir }, "saving waybar dir");
    await copyDirContents(systemDir, repoDir);
  });

  waybar.command("load").action(async () => {
    logger.info({ dir: systemDir }, "cleaning waybar system dir");
    await fs.rm(systemDir, { recursive: true, force: true });
    logger.info({ from: repoDir, to: systemDir }, "loading waybar dir");
    await fs.mkdir(systemDir, { recursive: true });
    await copyDirContents(repoDir, systemDir);
  });
};
