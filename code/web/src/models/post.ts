import type { Interest } from "./interest";
import type { User } from "./user";

export type Post = {
    id: string;
    title: string;
    body: string;
    author: User;
    interests: Interest[];
}