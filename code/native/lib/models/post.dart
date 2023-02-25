import 'package:local/models/person.dart';

enum Visibility { public, private, unlisted }

class Post {
  final int postID;
  final DateTime createdAt;
  final String title;
  final String body;
  final Visibility visibility;

  Post({
    required this.postID,
    required this.poster,
    required this.createdAt,
    required this.title,
    required this.body,
    required this.visibility,
  });
  // generated
  final Person poster;
  // final Location location;
  // final Interest[] interests;
  // final Group group;
  // final Space space;
}
