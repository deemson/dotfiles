import fs from "node:fs/promises";
import path from "node:path";
import { parse as parseYaml } from "yaml";
import z from "zod";
import { configDir } from "@/lib/paths";

const pathSchema = z.strictObject({
  system: z.string().min(1),
  repo: z.string().min(1),
});

const appSchema = z.strictObject({
  name: z.string().min(1),
  paths: z.array(pathSchema).min(1),
});

const tempConfigSchema = z.strictObject({
  inherit: z.array(z.string().min(1)).min(1).optional(),
  abstract: z.boolean().optional(),
  apps: z.array(appSchema).min(1),
});

export const configJsonSchema = tempConfigSchema.toJSONSchema({ target: "draft-2020-12" });

export const configSchema = tempConfigSchema.transform((v) => {
  return {
    ...v,
    abstract: !!v.abstract,
    inherit: v.inherit || [],
  };
});

export type Config = { name: string } & z.output<typeof configSchema>;

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
        throw new Error(`Failed to load profile "${name}": ${err}`);
      }
    }),
  );
  return configs;
};

export type App = { config: string } & Config["apps"][number];
export type Path = App["paths"][number];

export interface Profile {
  name: string;
  apps: App[];
}

const mergeApps = (...appLists: App[][]): App[] => {
  const appIndexes = new Map<string, number>();
  const apps: App[] = [];
  for (const appList of appLists) {
    for (const app of appList) {
      const appIndex = appIndexes.get(app.name);
      if (appIndex === undefined) {
        appIndexes.set(app.name, apps.length);
        apps.push(app);
        continue;
      }
      apps[appIndex] = app;
    }
  }
  return apps;
};

const resolveProfile = (
  name: string,
  profileMap: Map<string, Profile>,
  configMap: Map<string, Config>,
  visitingSet: Set<string>,
  visitingStack: string[],
): Profile => {
  const alreadyResolvedProfile = profileMap.get(name);
  if (alreadyResolvedProfile !== undefined) {
    return alreadyResolvedProfile;
  }

  if (visitingSet.has(name)) {
    throw new Error(`Circular inheritance detected: ${[...visitingStack, name].join(" → ")}`);
  }

  const config = configMap.get(name);
  if (config === undefined) {
    throw new Error(`Unknown config: "${name}"`);
  }
  const profileApps = config.apps.map((a) => ({ ...a, config: config.name }));

  visitingSet.add(name);
  visitingStack.push(name);
  try {
    const parentConfigs = config.inherit.map((parentName) =>
      resolveProfile(parentName, profileMap, configMap, visitingSet, visitingStack),
    );

    const resolvedProfile: Profile = {
      name: config.name,
      apps: mergeApps(...parentConfigs.map((p) => p.apps), profileApps),
    };

    visitingStack.pop();
    visitingSet.delete(name);
    profileMap.set(name, resolvedProfile);

    return resolvedProfile;
  } catch (err) {
    throw new Error(`Failed resolving "${name}" config: "${err}"`);
  }
};

export const loadProfiles = async (): Promise<Profile[]> => {
  const configs = await loadConfigs();
  const configMap = new Map<string, Config>();
  for (const config of configs) {
    configMap.set(config.name, config);
  }
  const profileMap = new Map<string, Profile>();
  const profiles: Profile[] = [];
  for (const config of configs) {
    const profile = resolveProfile(config.name, profileMap, configMap, new Set(), []);
    if (!config.abstract) {
      profiles.push(profile);
    }
  }
  return profiles;
};

export const loadCurrentProfile = async (): Promise<Profile> => {
  const profileName = process.env["DOTFILES_PROFILE"];
  if (profileName === undefined) {
    throw new Error("Env var DOTFILES_PROFILE is not set");
  }
  const profiles = await loadProfiles();
  const knownProfileNames: string[] = [];
  for (const profile of profiles) {
    if (profile.name === profileName) {
      return profile;
    }
    knownProfileNames.push(profile.name);
  }
  throw new Error(`Unkown profile name "${profileName}": choose from [${knownProfileNames.join(", ")}]`);
};
