import { logger } from "@/lib/logging";
import { Command } from "commander";
import { tmpdir } from "os";
import path from "path";
import { pipeline } from "stream/promises";
import { createWriteStream } from "fs";
import { execa } from "execa";

export const hammerspoonCommand = new Command("hammerspoon").description("manage hammerspoon");

const emmyLuaDownloadURL = "https://github.com/Hammerspoon/Spoons/raw/master/Spoons/EmmyLua.spoon.zip";

hammerspoonCommand
  .command("install-emmy-lua")
  .description("install EmmyLua for HS autocompletion in lua language server")
  .action(async () => {
    const tmpDir = tmpdir();

    const zipDownloadPath = path.join(tmpDir, "EmmyLua.spoon.zip");
    logger.debug({ to: zipDownloadPath }, "downloading");
    const fetchResult = await fetch(emmyLuaDownloadURL);
    if (!fetchResult.ok) {
      logger.error(
        {
          url: emmyLuaDownloadURL,
          status: fetchResult.status,
          statusText: fetchResult.statusText,
        },
        "failed to fetch EmmyLua",
      );
      return;
    }
    await pipeline(fetchResult.body as any, createWriteStream(zipDownloadPath));
    logger.info({ path: zipDownloadPath }, "done");

    const unzipFolder = path.join(tmpDir, "EmmyLua.spoon");
    try {
      logger.debug({ from: zipDownloadPath, to: unzipFolder }, "unzipping");
      const { all: unzipOutput, code: unzipCode } = await execa({
        all: true,
      })`unzip ${zipDownloadPath} -d ${unzipFolder}`;
      if (unzipCode) {
        logger.error({ code: unzipCode, out: unzipOutput }, "failed to unzip");
        return;
      }
      logger.info({ path: unzipFolder }, "done");
      const subFolder = path.join(unzipFolder, "EmmyLua.spoon");
      logger.debug({ path: subFolder }, "opening unzipped spoon folder");
      const { all: openOutput, code: openCode } = await execa({
        all: true,
      })`open ${subFolder}`;
      if (openCode) {
        logger.error({ code: openCode, out: openOutput }, "failed to open");
        return;
      }
    } finally {
      await cleanupEmmyLuaDownload(zipDownloadPath, unzipFolder);
    }
  });

const cleanupEmmyLuaDownload = async (zipPath: string, folderPath: string) => {
  logger.debug(
    {
      zipPath,
      unzippedFolder: folderPath,
    },
    "cleaning up",
  );
  const [{ all: zipOut, code: zipCode }, { all: folderOut, code: folderCode }] = await Promise.all([
    execa({ all: true })`rm ${zipPath}`,
    execa({ all: true })`rm -rf ${folderPath}`,
  ]);
  if (zipCode) {
    logger.error({ code: zipCode, out: zipOut, path: zipPath }, "failed to remove zip file");
  }
  if (folderCode) {
    logger.error({ code: folderCode, out: folderOut, path: folderPath }, "failed to remove folder");
  }
};
