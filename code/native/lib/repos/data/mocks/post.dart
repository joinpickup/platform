import 'package:local/repos/data/mocks/interest.dart';
import 'package:local/repos/data/mocks/person.dart';
import 'package:local/repos/data/models/post.dart';

final andrewPost = Post(
  postID: 1,
  interestID: 1,
  posterID: 1,
  createdAt: DateTime.now().subtract(
    const Duration(
      minutes: 15,
    ),
  ),
  title: "Need an extra person for trivia",
  body:
      "Usually we have six people for trivia at the bar downtown, but one person cancelled tonight. You don't have to be good, its pretty non competitive.",
  visibility: PostVisibility.public,
  poster: andrew,
  interest: triviaInterest,
);

final brianPost = Post(
  postID: 2,
  interestID: 1,
  posterID: 1,
  createdAt: DateTime.now().subtract(
    const Duration(minutes: 25),
  ),
  title: "Need a tennis partner for a doubles tournament",
  body:
      "Playing a low key doubles tournament this weekend, anyone around? Ideally you'd have a bit of experience playing.",
  visibility: PostVisibility.public,
  poster: brian,
  interest: tennisInterest,
);

final jayPost = Post(
  postID: 3,
  interestID: 1,
  posterID: 1,
  createdAt: DateTime.now().subtract(
    const Duration(minutes: 45),
  ),
  title: "Looking to play some catan?",
  body:
      "Really want to play some catan if anyone is around this weekend. Ideally four people, but I'm down to play with three.",
  visibility: PostVisibility.public,
  poster: jay,
  interest: catanInterest,
);

final allPosts = [andrewPost, brianPost, jayPost];
