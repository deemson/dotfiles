import fs from "node:fs/promises";
import path from "node:path";
import { parse as parseYaml } from "yaml";
import { EnvConfig } from "@/config/config-types";
import { envConfigSchema } from "@/config/schema";
import { configDir } from "@/lib/paths";

export const loadEnvConfigs = async (): Promise<EnvConfig[]> => {
  const envConfigDir = path.join(configDir, "envs");
  const configDirItems = await fs.readdir(envConfigDir);
  const configFiles = configDirItems.filter((v) => v.endsWith(".yaml"));
  const configs = await Promise.all(
    configFiles.map(async (configFile) => {
      const name = path.basename(configFile, ".yaml");
      const content = await fs.readFile(path.join(envConfigDir, configFile), "utf-8");
      try {
        const config = envConfigSchema.parse(parseYaml(content));
        return { ...config, name };
      } catch (err) {
        throw new Error(`Failed to load config "${name}": ${err}`);
      }
    }),
  );
  return configs;
};
