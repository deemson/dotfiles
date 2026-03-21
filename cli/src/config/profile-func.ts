import { Config } from "@/config/config-types";
import { Profile, ProfileApp } from "@/config/profile-types";
import { loadConfigs } from "@/config/config-func";

const mergeApps = (...appLists: ProfileApp[][]): ProfileApp[] => {
  const appIndexes = new Map<string, number>();
  const apps: ProfileApp[] = [];
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
