import fs from "node:fs/promises";
import path from "node:path";
import { parse as parseYaml } from "yaml";
import { Config } from "@/config/config-types";
import { configSchema } from "@/config/schema";
import { configDir } from "@/lib/paths";

export const loadConfigs = async (): Promise<Config[]> => {
  const configDirItems = await fs.readdir(configDir);
  const configFiles = configDirItems.filter((v) => v.endsWith(".yaml"));
  const configs = await Promise.all(
    configFiles.map(async (configFile) => {
      const name = path.basename(configFile, ".yaml");
      const content = await fs.readFile(path.join(configDir, configFile), "utf-8");
      try {
        const config = configSchema.parse(parseYaml(content));
        return { ...config, name };
      } catch (err) {
        throw new Error(`Failed to load config "${name}": ${err}`);
      }
    }),
  );
  return configs;
};
