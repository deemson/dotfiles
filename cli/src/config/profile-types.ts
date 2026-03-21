import { ConfigPath } from "@/config/config-types";

export type ProfilePath = ConfigPath;

export interface ProfileApp {
  config: string;
  name: string;
  paths: ProfilePath[];
}

export interface Profile {
  name: string;
  apps: ProfileApp[];
}
