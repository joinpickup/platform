import Image from "./image";
import Space from "./space";
import Interest from "./interest";
import Person from "./person";
import { Object } from "./object";
import { Location } from "./location";

export default interface Event extends Object {
  // core
  id: number;
  name: string;
  start_time: string;
  end_time: string;
  description: string;
  cover: string;
  space: Space;
  location: Location;

  // generated
  participants: Person[];
  organizers: Person[];
  interests: Interest[];
}

export interface EventBody {
  name: string;
  description: string;
  cover: string;
  start_time: string;
  end_time: string;
}

export interface EventParticipant {
  id: number;
  event_id: number;
  user: Person;
  participant_type: string;
  participant_status: string;
}
