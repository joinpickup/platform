import 'package:local/mocks/location.dart';
import 'package:local/models/event.dart';

final climbingSession1 = Event(
  eventID: 1,
  location: eastRockClimb,
  description: "Just one of your basic climbing session for all ages.",
  name: "Climbing Session",
  startDate: DateTime.now(),
  startTime: "9:00",
  endDate: DateTime.now(),
  endTime: "10:00",
);

final climbingSession2 = Event(
  eventID: 2,
  location: eastRockClimb,
  description: "Not much climbing, really just a get together for fun!",
  name: "Climbing Social",
  startDate: DateTime.now(),
  startTime: "10:00",
  endDate: DateTime.now(),
  endTime: "11:00",
);
