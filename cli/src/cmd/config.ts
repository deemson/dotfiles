import { configJsonSchema } from "@/config";
import fs from "node:fs/promises";
import path from "node:path";
import { Command } from "commander";
import { configDir } from "@/lib/paths";
import { logger } from "@/lib/logging";

export const configCommand = new Command("config").description("manage config");

configCommand
  .command("schema")
  .option("-w, --write", "write schema into config folder")
  .action(async (_, command: Command) => {
    const data = JSON.stringify(configJsonSchema, null, 2);
    if (command.opts().write) {
      const schemaPath = path.join(configDir, "schema.json");
      fs.writeFile(schemaPath, data);
      logger.info({ path: schemaPath }, "wrote schema");
    } else {
      console.log(data);
    }
  });
