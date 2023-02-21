import Person from "./person";

export default interface Notifcation {
  id: number;
  type: string;
  status: string;
  actor: Person;
  reciever: Person;
  message: string;
  timestamp: Date;
}
