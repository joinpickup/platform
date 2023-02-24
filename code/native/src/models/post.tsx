import Group from "./group";
import Interest from "./interest";
import Person from "./person";
import Space from "./space";

export default interface Post {
  // core
  id: number;
  poster: Person;
  created_at: string;
  location: Location;
  title: string;
  body: string;
  group?: Group;
  space: Space;
  visibility: Visibility;

  // generated
  interests: Interest[];
}

export interface PostBody {
  title: string;
  body: string;
  space?: number;
  poster_id?: number;
}
