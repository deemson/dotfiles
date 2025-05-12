import { program } from "commander";
import type { MakeEnvironmentCommandsFunc, CommandsPerEnvironment, Environment } from "@/lib/environment";
import { allEnvironments } from "@/lib/environment";
// linux makers
import { makeSwayCommands } from "@/cmd/linux/sway"
import { makeWaybarCommands } from "@/cmd/linux/waybar"
import { makeWofiCommands } from "@/cmd/linux/wofi"
// other makers
import { makeBinscriptsCommands } from "@/cmd/binscripts";
import { makeGhosttyCommands } from "@/cmd/ghostty";
import { makeStarshipCommands } from "@/cmd/starship";
import { makeNeovimCommands } from "@/cmd/neovim";
import { makeZshCommands } from "@/cmd/zsh";

const linuxCommandMakers: MakeEnvironmentCommandsFunc[] = [
  makeSwayCommands,
  makeWaybarCommands,
  makeWofiCommands
]
const commandMakers: MakeEnvironmentCommandsFunc[] = [
  makeBinscriptsCommands,
  makeGhosttyCommands,
  makeStarshipCommands,
  makeNeovimCommands,
  makeZshCommands,
  ...linuxCommandMakers,
];
const commandsPerEnvironment = Object.fromEntries(
  allEnvironments.map((environment: Environment) => {
    const command = program.command(environment);
    return [environment, command];
  }),
) as CommandsPerEnvironment;
for (const commandMaker of commandMakers) {
  commandMaker(commandsPerEnvironment);
}

program.parse();
