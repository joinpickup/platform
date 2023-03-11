import 'package:local/repos/data/mocks/interest.dart';
import 'package:local/repos/data/mocks/person.dart';
import 'package:local/repos/data/models/post.dart';

final andrewPost = Post(
  postID: 1,
  createdAt: DateTime.now().subtract(
    const Duration(
      minutes: 15,
    ),
  ),
  title: "Looking for a belay buddy",
  body: "I have minimal experience so there's a solid chance you'll die. Oops",
  visibility: PostVisibility.public,
  poster: andrew,
  interest: rockClimbingInterest,
);

final brianPost = Post(
  postID: 2,
  createdAt: DateTime.now().subtract(
    const Duration(minutes: 25),
  ),
  title: "Anyone want to belay?",
  body:
      "I'm open to meeting with anyone. Except that guy with minimal experience.",
  visibility: PostVisibility.private,
  poster: brian,
  interest: rockClimbingInterest,
);

final jayPost = Post(
  postID: 3,
  createdAt: DateTime.now().subtract(
    const Duration(minutes: 45),
  ),
  title: "Looking to play some catan?",
  body: "Really want to play some catan if anyone is around this weekend",
  visibility: PostVisibility.public,
  poster: jay,
  interest: catanInterest,
);

final allPosts = [andrewPost, brianPost, jayPost];
