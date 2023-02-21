import { ActivityType } from "./activityType";

export default interface Activity {
  id: number;
  name: string;
  type: ActivityType;
  time: number;
  timestamp: Date;
}
