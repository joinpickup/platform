import 'package:local/repos/data/mocks/person.dart';
import 'package:local/repos/data/mocks/post.dart';
import 'package:local/repos/data/models/post/comment.dart';

final comment1 = Comment(
  commentID: 1,
  createdAt: DateTime.now(),
  parentComment: null,
  body: "Have a question about this",
  poster: brian,
  post: andrewPost,
);

final comment2 = Comment(
  commentID: 2,
  createdAt: DateTime.now(),
  parentComment: comment1,
  body: "I also have a question about this",
  poster: stef,
  post: andrewPost,
);
