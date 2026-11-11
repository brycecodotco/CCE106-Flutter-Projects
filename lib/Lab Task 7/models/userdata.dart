import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import 'account.dart';
import 'friend.dart';
import 'usercomment.dart';
import 'userpost.dart';

Usercomment _c(String img, String name, String text, Duration ago,
        {int likes = 0}) =>
    Usercomment(
      commenterImg: img,
      commenterName: name,
      commentContent: text,
      createdAt: DateTime.now().subtract(ago),
      likes: likes,
    );

class Userdata {
  final List<Userpost> userList = [
    Userpost(
      id: 'post1',
      userimg: 'assets/user1.jpg',
      username: 'John Doe',
      time: '2h ago',
      postcontent: 'This is a sample post content',
      postimg: 'assets/post1.jpg',
      numshare: '10',
      isLiked: false,
      comments: [
        _c('assets/user2.jpg', 'Jane Smith', 'Nice one!',
            const Duration(hours: 1), likes: 2),
      ],
    ),
    Userpost(
      id: 'post2',
      userimg: 'assets/user2.jpg',
      username: 'Jane Smith',
      time: '5h ago',
      postcontent: 'Another sample post content',
      postimg: 'assets/post2.jpg',
      numshare: '20',
      isLiked: true,
      comments: [
        _c('assets/user3.jpg', 'Alice Johnson', 'Love this.',
            const Duration(hours: 4)),
      ],
    ),
    Userpost(
      id: 'post3',
      userimg: 'assets/user3.jpg',
      username: 'Alice Johnson',
      time: '1d ago',
      postcontent: 'Yet another sample post content',
      postimg: 'assets/post3.jpg',
      numshare: '30',
      isLiked: false,
    ),
    Userpost(
      id: 'post4',
      userimg: 'assets/user4.jpg',
      username: 'Bob Brown',
      time: '2d ago',
      postcontent: 'Sample post content from Bob',
      postimg: 'assets/post4.jpg',
      numshare: '12',
      isLiked: true,
    ),
  ];

  final List<Friend> friendList = [
    Friend(img: 'assets/user1.jpg', name: 'John Doe'),
    Friend(img: 'assets/user2.jpg', name: 'Jane Smith'),
    Friend(img: 'assets/user3.jpg', name: 'Alice Johnson'),
    Friend(img: 'assets/user4.jpg', name: 'Bob Brown'),
    Friend(img: 'assets/user5.jpg', name: 'Charlie Davis'),
    Friend(img: 'assets/user6.jpg', name: 'Emily Wilson'),
  ];

  final Account myUserAccount = Account(
    name: 'John Doe',
    email: 'john.doe@example.com',
    img: 'assets/user1.jpg',
    numFollowers: '100',
    numPosts: '50',
    numFollowing: '75',
    numFriends: '30',
  );

  static String _key(Userpost p) => 'comments_${p.id}';

  /// Call once at startup, before showing the posts.
  Future<void> loadComments() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      for (final post in userList) {
        final raw = prefs.getString(_key(post));
        if (raw == null) continue;
        final loaded = (jsonDecode(raw) as List)
            .map((e) => Usercomment.fromJson(e as Map<String, dynamic>))
            .toList();
        post.comments
          ..clear()
          ..addAll(loaded);
      }
    } catch (_) {
      // Unreadable saved data: keep the built-in sample comments.
    }
  }

  /// Saves one post's comments. Returns false if saving failed.
  Future<bool> saveComments(Userpost post) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      return await prefs.setString(
        _key(post),
        jsonEncode(post.comments.map((c) => c.toJson()).toList()),
      );
    } catch (_) {
      return false;
    }
  }
}