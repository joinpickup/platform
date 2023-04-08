import 'package:local/repos/data/mocks/space.dart';
import 'package:local/repos/data/models/space/interest.dart';

const rockClimbingInterest = Interest(
  space: sportsSpace,
  interestID: 1,
  name: "Rock-Climbing",
);
const soccerInterest = Interest(
  space: sportsSpace,
  interestID: 2,
  name: "Soccer",
);
const baseballInterest = Interest(
  space: sportsSpace,
  interestID: 3,
  name: "Baseball",
);
const tennisInterest = Interest(
  space: sportsSpace,
  interestID: 4,
  name: "Tennis",
);

const triviaInterest = Interest(
  space: tabletopSpace,
  interestID: 5,
  name: "Trivia",
);

const catanInterest = Interest(
  space: tabletopSpace,
  interestID: 6,
  name: "Settlers-Of-Catan",
);

const monopolyInterest = Interest(
  space: tabletopSpace,
  interestID: 7,
  name: "Monopoly",
);

const chessInterest = Interest(
  space: tabletopSpace,
  interestID: 8,
  name: "Chess",
);

const rockInterest = Interest(
  space: musicSpace,
  interestID: 9,
  name: "Rock",
);

const countryInterest = Interest(
  space: musicSpace,
  interestID: 10,
  name: "Country",
);

const indieInterest = Interest(
  space: musicSpace,
  interestID: 11,
  name: "Indie",
);

final allInterests = [
  rockClimbingInterest,
  soccerInterest,
  baseballInterest,
  tennisInterest,
  triviaInterest,
  catanInterest,
  monopolyInterest,
  chessInterest,
  rockInterest,
  countryInterest,
  indieInterest,
];
