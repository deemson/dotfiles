import { program } from "commander";
import { dotfilesDir, homeDir } from "../lib/paths.ts";
import path from "node:path";
import fs from "node:fs/promises";
import { logger } from "../lib/logging.ts";
import { copyDirContents } from "../lib/fsutils.ts";

export const neovimCommands = () => {
  const repoDir = path.join(dotfilesDir, "neovim");
  const systemDir = path.join(homeDir, ".config", "nvim");
  const systemLuaDir = path.join(systemDir, "lua");
  const repoLuaDir = path.join(repoDir, "lua");
  const systemInitLua = path.join(systemDir, "init.lua");
  const repoInitLua = path.join(repoDir, "init.lua");

  const neovim = program.command("neovim");

  neovim.command("save").action(async () => {
    logger.info({ dir: repoDir }, "cleaning neovim repo dir");
    await fs.rm(repoDir, { recursive: true, force: true });
    logger.info({ from: systemLuaDir, to: repoLuaDir }, "saving neovim lua/");
    await copyDirContents(systemLuaDir, repoLuaDir);
    logger.info({ from: systemInitLua, to: repoInitLua }, "saving neovim init.lua");
    await fs.copyFile(systemInitLua, repoInitLua);
  });

  neovim.command("load").action(async () => {
    logger.info({ dir: systemLuaDir }, "cleaning neovim system dir");
    await fs.rm(systemLuaDir, { recursive: true, force: true });
    logger.info({ from: repoLuaDir, to: systemLuaDir }, "loading neovim lua/");
    await copyDirContents(repoLuaDir, systemLuaDir);
    logger.info({ from: repoInitLua, to: systemInitLua }, "loading neovim init.lua");
    await fs.copyFile(repoInitLua, systemInitLua);
  });
};
