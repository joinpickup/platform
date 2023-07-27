import type { User } from "./user";

export type Post = {
    title: string;
    body: string;
    author: User;
}