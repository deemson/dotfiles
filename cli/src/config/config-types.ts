import { configSchema } from "@/config/schema";
import z from "zod";

export type Config = { name: string } & z.output<typeof configSchema>;
export type ConfigApp = Config["apps"][number];
export type ConfigPath = ConfigApp["paths"][number];
