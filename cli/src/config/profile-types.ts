import { AppPath } from "@/config/config-types";

export type ProfilePath = AppPath;

export interface ProfileApp {
  repoPath: string;
  name: string;
  paths: ProfilePath[];
}

export interface Profile {
  name: string;
  apps: ProfileApp[];
}
