import type { Command } from "commander";

export const allEnvironments = ["shared", "macos", "linux"] as const;
export type Environment = (typeof allEnvironments)[number];

export type CommandsPerEnvironment = Record<Environment, Command>;
export type MakeEnvironmentCommandsFunc = (commandsPerEnvironment: CommandsPerEnvironment) => void;
