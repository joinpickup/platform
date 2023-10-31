export type Space = {
    id: string;
    name: string;
}

export type Interest = {
    id: string;
    name: string;
    space: Space;
}