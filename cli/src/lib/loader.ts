import fs from "node:fs/promises";
import path from "node:path";
import { parse as parseYaml } from "yaml";
import { configSchema } from "@/lib/config";
import type { Config } from "@/lib/config";
import { configDir } from "@/lib/paths";

export type ProfileMap = Map<string, Config>;

type App = Config["apps"][number];

function mergeApps(...appLists: App[][]): App[] {
  const acc = new Map<string, App>();
  for (const list of appLists) {
    for (const app of list) {
      acc.set(app.name, app);
    }
  }
  return [...acc.values()];
}

function resolveProfile(
  name: string,
  rawMap: Map<string, Config>,
  resolved: Map<string, Config>,
  visiting: Set<string>,
  visitingStack: string[],
): Config {
  const cached = resolved.get(name);
  if (cached !== undefined) return cached;

  if (visiting.has(name)) {
    throw new Error(`Circular inheritance detected: ${[...visitingStack, name].join(" → ")}`);
  }

  const raw = rawMap.get(name);
  if (raw === undefined) {
    throw new Error(`Unknown profile referenced in inherit: "${name}"`);
  }

  visiting.add(name);
  visitingStack.push(name);

  const parentConfigs = raw.inherit.map((parentName) =>
    resolveProfile(parentName, rawMap, resolved, visiting, visitingStack),
  );

  const result: Config = {
    ...raw,
    apps: mergeApps(...parentConfigs.map((p) => p.apps), raw.apps),
  };

  visitingStack.pop();
  visiting.delete(name);
  resolved.set(name, result);
  return result;
}

export async function loadProfiles(): Promise<ProfileMap> {
  const entries = await fs.readdir(configDir);
  const yamlFiles = entries.filter((e) => e.endsWith(".yaml"));

  const rawMap = new Map<string, Config>();
  for (const filename of yamlFiles) {
    const name = path.basename(filename, ".yaml");
    const content = await fs.readFile(path.join(configDir, filename), "utf-8");
    try {
      rawMap.set(name, configSchema.parse(parseYaml(content)));
    } catch (err) {
      throw new Error(`Failed to load profile "${name}": ${err}`);
    }
  }

  const resolved = new Map<string, Config>();
  for (const name of rawMap.keys()) {
    resolveProfile(name, rawMap, resolved, new Set(), []);
  }

  const output: ProfileMap = new Map();
  for (const [name, config] of resolved) {
    if (!config.abstract) output.set(name, config);
  }
  return output;
}
