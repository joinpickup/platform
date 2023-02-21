import Event from "./event";
import Group from "./group";
import { Object } from "./object";
import Space from "./space";
import Interest from "./interest";

export default interface Person extends Object {
  id: number;
  username: string;
  phone: string;
  email: string;
  avatar: string;
  name: string;
  bio: string;
  space: Space;

  // optional
  tags?: Interest[];
  mutuals?: Person[];
  saved?: (Person | Group | Event)[];
  history?: (Person | Group | Event)[];
}
