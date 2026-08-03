import { envConfigJsonSchema, appConfigJsonSchema } from "@/config";
import fs from "node:fs/promises";
import path from "node:path";
import { Command } from "commander";
import { configAppsDir, configEnvsDir } from "@/lib/paths";
import { logger } from "@/lib/logging";

export const configCommand = new Command("config").description("manage config");

interface CommandDef {
  name: string;
  description: string;
  jsonSchema: any;
  schemaPath: string;
}

const commandDefs: CommandDef[] = [
  {
    name: "apps",
    description: "manage apps config",
    jsonSchema: appConfigJsonSchema,
    schemaPath: path.join(configAppsDir, "schema.json"),
  },
  {
    name: "envs",
    description: "manage envs config",
    jsonSchema: envConfigJsonSchema,
    schemaPath: path.join(configEnvsDir, "schema.json"),
  },
];

for (const commandDef of commandDefs) {
  configCommand
    .command(commandDef.name)
    .description(commandDef.description)
    .option("-w, --write", "write schema into config folder")
    .action(async (_, command: Command) => {
      const data = JSON.stringify(commandDef.jsonSchema, null, 2);
      if (command.opts().write) {
        await fs.writeFile(commandDef.schemaPath, data);
        logger.info({ path: commandDef.schemaPath }, "wrote schema");
      } else {
        console.log(data);
      }
    });
}
