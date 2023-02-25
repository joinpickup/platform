import 'package:local/mocks/person.dart';
import 'package:local/models/post.dart';

final andrewPost = Post(
  postID: 1,
  createdAt: DateTime.now(),
  title: "Looking for a belay buddy",
  body: "I have minimal experience so there's a solid chance you'll die. Oops",
  visibility: Visibility.public,
  poster: andrew,
);

final brianPost = Post(
  postID: 2,
  createdAt: DateTime.now(),
  title: "Anyone want to belay?",
  body:
      "I'm open to meeting with anyone. Except that guy with minimal experience.",
  visibility: Visibility.private,
  poster: brian,
);
