import Image from "./image";
import Space from "./space";
import Person from "./person";
import { Object } from "./object";

export default interface Group extends Object {
  id: number;
  name: string;
  avatar: string;
  group_slug: string;
  image: Image;
  description: string;
  members: Person[];
  space: Space;
}

export interface GroupMember {
  id: number;
  user_id: number;
  group_id: number;
  user: Person;
  member_type: string;
}

export interface GroupBody {
  name: string;
  avatar: string;
  group_slug: string;
  description: string;
}
