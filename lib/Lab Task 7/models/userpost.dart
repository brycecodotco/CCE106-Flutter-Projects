import 'usercomment.dart';

class Userpost {
  /// Stable id, used as the storage key for this post's comments.
  final String id;
  final String userimg;
  final String username;
  final String time;
  final String postcontent;
  final String postimg;
  final String numshare;
  bool isLiked;
  final List<Usercomment> comments;

  Userpost({
    required this.id,
    required this.userimg,
    required this.username,
    required this.time,
    required this.postcontent,
    required this.postimg,
    required this.numshare,
    required this.isLiked,
    List<Usercomment>? comments,
  }) : comments = comments ?? [];

  /// Always matches the real list, so the count can't go stale.
  String get numcomments => comments.length.toString();
}