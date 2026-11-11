class Usercomment {
  final String commenterImg;
  final String commenterName;
  final String commentContent;
  final DateTime createdAt;
  int likes;
  bool isLiked;

  Usercomment({
    required this.commenterImg,
    required this.commenterName,
    required this.commentContent,
    DateTime? createdAt,
    this.likes = 0,
    this.isLiked = false,
  }) : createdAt = createdAt ?? DateTime.now();

  /// Short relative time, computed from [createdAt] so it is always correct.
  String get timeAgo {
    final d = DateTime.now().difference(createdAt);
    if (d.inSeconds < 60) return 'Just now';
    if (d.inMinutes < 60) return '${d.inMinutes}m';
    if (d.inHours < 24) return '${d.inHours}h';
    if (d.inDays < 7) return '${d.inDays}d';
    return '${d.inDays ~/ 7}w';
  }

  Map<String, dynamic> toJson() => {
        'commenterImg': commenterImg,
        'commenterName': commenterName,
        'commentContent': commentContent,
        'createdAt': createdAt.toIso8601String(),
        'likes': likes,
        'isLiked': isLiked,
      };

  factory Usercomment.fromJson(Map<String, dynamic> json) => Usercomment(
        commenterImg: json['commenterImg'] as String,
        commenterName: json['commenterName'] as String,
        commentContent: json['commentContent'] as String,
        createdAt: DateTime.parse(json['createdAt'] as String),
        likes: (json['likes'] as num?)?.toInt() ?? 0,
        isLiked: json['isLiked'] as bool? ?? false,
      );
}