import 'package:flutter/material.dart';

import '../models/userdata.dart';
import '../models/userpost.dart';
import 'profileview.dart';

class Postlist extends StatefulWidget {
  const Postlist({
    super.key,
    required this.userdata,
    this.shrinkWrap = false,
    this.physics,
  });

  final Userdata userdata;

  /// Set shrinkWrap: true and physics: NeverScrollableScrollPhysics() when the
  /// list lives inside another scrollable (ListView / SingleChildScrollView).
  /// Leave the defaults when it is inside an Expanded.
  final bool shrinkWrap;
  final ScrollPhysics? physics;

  @override
  State<Postlist> createState() => _PostlistState();
}

class _PostlistState extends State<Postlist> {
  Future<void> _openPost(Userpost post) async {
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => ProfileView(userPost: post, userdata: widget.userdata),
      ),
    );
    // Refresh the comment count / like state after coming back.
    if (mounted) setState(() {});
  }

  Widget _image(String path) => Image.asset(
        path,
        width: double.infinity,
        height: 220,
        fit: BoxFit.cover,
        errorBuilder: (_, __, ___) => Container(
          height: 220,
          color: Colors.grey.shade300,
          alignment: Alignment.center,
          child: const Icon(Icons.broken_image, color: Colors.grey),
        ),
      );

  Widget _postCard(Userpost post) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
      clipBehavior: Clip.antiAlias,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ListTile(
            leading: CircleAvatar(backgroundImage: AssetImage(post.userimg)),
            title: Text(
              post.username,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            subtitle: Text(post.time),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
            child: Text(post.postcontent),
          ),
          GestureDetector(
            onTap: () => _openPost(post),
            child: _image(post.postimg),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(12, 8, 12, 0),
            child: Align(
              alignment: Alignment.centerRight,
              child: Text('${post.numcomments} comments • ${post.numshare} shares'),
            ),
          ),
          const Divider(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              TextButton.icon(
                style: TextButton.styleFrom(
                  foregroundColor: post.isLiked ? Colors.blue : Colors.grey,
                ),
                onPressed: () => setState(() => post.isLiked = !post.isLiked),
                icon: const Icon(Icons.thumb_up, size: 20),
                label: const Text('Like'),
              ),
              TextButton.icon(
                style: TextButton.styleFrom(foregroundColor: Colors.grey),
                onPressed: () => _openPost(post),
                icon: const Icon(Icons.chat_bubble, size: 20),
                label: const Text('Comment'),
              ),
              TextButton.icon(
                style: TextButton.styleFrom(foregroundColor: Colors.grey),
                onPressed: () {},
                icon: const Icon(Icons.share, size: 20),
                label: const Text('Share'),
              ),
            ],
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final posts = widget.userdata.userList;
    return ListView.builder(
      shrinkWrap: widget.shrinkWrap,
      physics: widget.physics,
      itemCount: posts.length,
      itemBuilder: (_, i) => _postCard(posts[i]),
    );
  }
}