import { Command } from "commander";
import { hammerspoonCommand } from "@/cmd/apps/hammerspoon";

export const appsCommand = new Command("apps").description("manage apps");

appsCommand.addCommand(hammerspoonCommand);
