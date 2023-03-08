import 'package:local/repos/data/models/interest.dart';
import 'package:local/repos/data/models/person.dart';

enum PostVisibility { public, private, unlisted }

class Post {
  final int postID;
  final DateTime createdAt;
  final String title;
  final String body;
  final PostVisibility visibility;

  // generated
  final Person poster;
  final Interest interest;
  // final Group group;
  // final Space space;

  Post({
    required this.postID,
    required this.poster,
    required this.createdAt,
    required this.title,
    required this.body,
    required this.visibility,
    required this.interest,
  });
}
