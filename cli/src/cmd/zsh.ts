import { dotfilesDir, homeDir } from "@/lib/paths";
import path from "node:path";
import fs from "node:fs/promises";
import { logger } from "@/lib/logging";
import { copyDirContents } from "@/lib/fsutils";

import type { CommandsPerEnvironment, MakeEnvironmentCommandsFunc } from "@/lib/environment";

export const makeZshCommands: MakeEnvironmentCommandsFunc = (commandsPerEnvironment: CommandsPerEnvironment) => {
  const repoDir = path.join(dotfilesDir, "shared", "zsh");
  const systemDotZshDir = path.join(homeDir, ".zsh");
  const repoDotZshDir = path.join(repoDir, "dotzsh");
  const systemDotZshRC = path.join(homeDir, ".zshrc");
  const repoDotZshRC = path.join(repoDir, "dotzsh.zsh");

  const zsh = commandsPerEnvironment["shared"].command("zsh");

  zsh.command("save").action(async () => {
    logger.info({ dir: repoDir }, "cleaning zsh repo dir");
    await fs.rm(repoDir, { recursive: true, force: true });
    logger.info({ from: systemDotZshDir, to: repoDotZshDir }, "saving .zsh/");
    await copyDirContents(systemDotZshDir, repoDotZshDir);
    logger.info({ from: systemDotZshRC, to: repoDotZshRC }, "saving .zshrc");
    await fs.copyFile(systemDotZshRC, repoDotZshRC);
  });

  zsh.command("load").action(async () => {
    logger.info({ dir: systemDotZshDir }, "cleaning zsh system dir");
    await fs.rm(systemDotZshDir, { recursive: true, force: true });
    logger.info({ from: repoDotZshDir, to: systemDotZshDir }, "loading .zsh/");
    await copyDirContents(repoDotZshDir, systemDotZshDir);
    logger.info({ from: repoDotZshRC, to: systemDotZshRC }, "loading .zshrc");
    await fs.copyFile(repoDotZshRC, systemDotZshRC);
  });
};
