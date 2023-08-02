import type { User } from "./user";

export type Post = {
    id: string;
    title: string;
    body: string;
    author: User;
}