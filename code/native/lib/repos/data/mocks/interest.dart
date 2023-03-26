import 'package:local/repos/data/models/space/interest.dart';

const rockClimbingInterest = Interest(interestID: 1, name: "Rock-Climbing");
const soccerInterest = Interest(interestID: 2, name: "Soccer");
const baseballInterest = Interest(interestID: 3, name: "Baseball");
const tennisInterest = Interest(interestID: 4, name: "Tennis");

const triviaInterest = Interest(interestID: 5, name: "Trivia");

const catanInterest = Interest(interestID: 6, name: "Settlers-Of-Catan");

final sportsInterests = [
  rockClimbingInterest,
  soccerInterest,
  baseballInterest,
  tennisInterest,
];

final casualInterests = [
  triviaInterest,
];

final tabletopInterest = [
  catanInterest,
];

final allInterests = [
  rockClimbingInterest,
  soccerInterest,
  baseballInterest,
  tennisInterest,
  triviaInterest,
  catanInterest
];
