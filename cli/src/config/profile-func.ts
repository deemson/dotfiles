import fs from "node:fs/promises";
import path from "node:path";
import { EnvConfig } from "@/config/config-types";
import { Profile, ProfileApp } from "@/config/profile-types";
import { loadEnvConfigs } from "@/config/config-func";
import { appConfigSchema } from "@/config/schema";
import { configDir } from "@/lib/paths";
import { parse as parseYaml } from "yaml";

const mergeApps = (...appLists: ProfileApp[][]): ProfileApp[] => {
  const appIndexes = new Map<string, number>();
  const apps: ProfileApp[] = [];
  for (const appList of appLists) {
    for (const app of appList) {
      const appIndex = appIndexes.get(app.repoPath);
      if (appIndex === undefined) {
        appIndexes.set(app.repoPath, apps.length);
        apps.push(app);
        continue;
      }
      apps[appIndex] = app;
    }
  }
  return apps;
};

const loadProfileApp = async (appConfigPath: string): Promise<ProfileApp> => {
  const appPath = path.join(configDir, "apps", `${appConfigPath}.yaml`);
  const content = await fs.readFile(appPath, "utf-8");
  try {
    return {
      repoPath: appConfigPath,
      name: path.basename(appConfigPath),
      paths: appConfigSchema.parse(parseYaml(content)),
    };
  } catch (err) {
    throw new Error(`Failed to load app "${appConfigPath}": ${err}`);
  }
};

const resolveProfile = (
  name: string,
  profileMap: Map<string, Profile>,
  configMap: Map<string, EnvConfig>,
  appMap: Map<string, ProfileApp>,
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
    throw new Error(`Unknown env config: "${name}"`);
  }
  const profileApps = config.apps.map((appConfigPath) => {
    const app = appMap.get(appConfigPath);
    if (app === undefined) {
      throw new Error(`Unknown app: "${appConfigPath}"`);
    }
    return app;
  });

  visitingSet.add(name);
  visitingStack.push(name);
  try {
    const parentConfigs = config.inherit.map((parentName) =>
      resolveProfile(parentName, profileMap, configMap, appMap, visitingSet, visitingStack),
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
  const envConfigs = await loadEnvConfigs();
  const envConfigMap = new Map<string, EnvConfig>();
  const appMap = new Map<string, ProfileApp>();
  for (const envConfig of envConfigs) {
    envConfigMap.set(envConfig.name, envConfig);
    for (const appConfigPath of envConfig.apps) {
      if (!appMap.has(appConfigPath)) {
        appMap.set(appConfigPath, await loadProfileApp(appConfigPath));
      }
    }
  }
  const profileMap = new Map<string, Profile>();
  const profiles: Profile[] = [];
  for (const config of envConfigs) {
    const profile = resolveProfile(config.name, profileMap, envConfigMap, appMap, new Set(), []);
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
  throw new Error(`Unknown profile name "${profileName}": choose from [${knownProfileNames.join(", ")}]`);
};
