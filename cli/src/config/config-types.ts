import { appConfigSchema, envConfigSchema } from "@/config/schema";
import z from "zod";

export type EnvConfig = { name: string } & z.output<typeof envConfigSchema>;
export type AppPath = z.output<typeof appConfigSchema>[number];
