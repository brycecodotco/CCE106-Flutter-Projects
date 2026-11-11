import 'package:flutter/material.dart';

import '../models/usercomment.dart';
import '../models/userdata.dart';
import '../models/userpost.dart';

enum CommentSort { newest, mostLiked, oldest }

class ProfileView extends StatefulWidget {
  const ProfileView({
    super.key,
    required this.userPost,
    required this.userdata,
  });

  final Userpost userPost;
  final Userdata userdata;

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  final TextEditingController commentController =
      TextEditingController();
  final ScrollController scrollController = ScrollController();
  final FocusNode commentFocus = FocusNode();
  final GlobalKey commentsHeaderKey = GlobalKey();

  CommentSort sort = CommentSort.newest;

  Userpost get post => widget.userPost;

  @override
  void dispose() {
    commentController.dispose();
    scrollController.dispose();
    commentFocus.dispose();
    super.dispose();
  }

  // ---------- SORTING (Newest / Most liked / Oldest) ----------

  String sortLabel(CommentSort s) {
    switch (s) {
      case CommentSort.newest:
        return 'Newest';
      case CommentSort.mostLiked:
        return 'Most liked';
      case CommentSort.oldest:
        return 'Oldest';
    }
  }

  List<Usercomment> get sortedComments {
    final list = List<Usercomment>.from(post.comments);

    switch (sort) {
      case CommentSort.newest:
        list.sort((a, b) => b.createdAt.compareTo(a.createdAt));
        break;

      case CommentSort.mostLiked:
        list.sort((a, b) {
          final byLikes = b.likes.compareTo(a.likes);
          return byLikes != 0
              ? byLikes
              : b.createdAt.compareTo(a.createdAt);
        });
        break;

      case CommentSort.oldest:
        list.sort((a, b) => a.createdAt.compareTo(b.createdAt));
        break;
    }

    return list;
  }

  // ---------- ADD COMMENT ----------

  Future<void> addComment() async {
    final text = commentController.text.trim();
    if (text.isEmpty) return;

    final me = widget.userdata.myUserAccount;

    setState(() {
      post.comments.add(
        Usercomment(
          commenterImg: me.img,
          commenterName: me.name,
          commentContent: text,
        ),
      );
      commentController.clear();
    });

    commentFocus.unfocus();

    // Save so the comment is still there after closing the app.
    final saved = await widget.userdata.saveComments(post);
    if (!mounted) return;

    if (!saved) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Comment could not be saved.')),
      );
    }

    // Bring the new comment into view.
    await Future.delayed(const Duration(milliseconds: 100));

    if (!mounted || !scrollController.hasClients) return;

    if (sort == CommentSort.oldest) {
      scrollController.animateTo(
        scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    } else {
      final ctx = commentsHeaderKey.currentContext;

      if (ctx != null) {
        Scrollable.ensureVisible(
          ctx,
          duration: const Duration(milliseconds: 300),
        );
      }
    }
  }

  // ---------- LIKE A COMMENT ----------

  Future<void> toggleLike(Usercomment c) async {
    setState(() {
      c.isLiked = !c.isLiked;
      c.likes += c.isLiked ? 1 : -1;
    });

    await widget.userdata.saveComments(post);
  }

  // ---------- REPLY ----------

  void replyTo(Usercomment c) {
    commentController.text = '@${c.commenterName} ';

    commentController.selection = TextSelection.collapsed(
      offset: commentController.text.length,
    );

    commentFocus.requestFocus();
  }

  // ---------- UI ----------

  Widget userline() => Padding(
        padding: const EdgeInsets.all(10),
        child: Row(
          children: [
            CircleAvatar(
              radius: 24,
              backgroundImage: AssetImage(post.userimg),
            ),
            const SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  post.username,
                  style: const TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  post.time,
                  style: const TextStyle(color: Colors.grey),
                ),
              ],
            ),
          ],
        ),
      );

  Widget postimage() => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 12,
              vertical: 6,
            ),
            child: Text(
              post.postcontent,
              style: const TextStyle(fontSize: 16),
            ),
          ),
          Image.asset(
            post.postimg,
            width: double.infinity,
            height: 240,
            fit: BoxFit.cover,
          ),
        ],
      );

  Widget buttons() => Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 12,
              vertical: 8,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(post.isLiked ? 'You liked this' : ''),
                Text(
                  '${post.numcomments} comments • ${post.numshare} shares',
                ),
              ],
            ),
          ),
          const Divider(color: Colors.grey),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              TextButton.icon(
                style: TextButton.styleFrom(
                  foregroundColor:
                      post.isLiked ? Colors.blue : Colors.grey,
                ),
                onPressed: () =>
                    setState(() => post.isLiked = !post.isLiked),
                icon: const Icon(Icons.thumb_up, size: 20),
                label: const Text('Like'),
              ),
              TextButton.icon(
                style: TextButton.styleFrom(
                  foregroundColor: Colors.grey,
                ),
                onPressed: () => commentFocus.requestFocus(),
                icon: const Icon(Icons.chat_bubble, size: 20),
                label: const Text('Comment'),
              ),
              TextButton.icon(
                style: TextButton.styleFrom(
                  foregroundColor: Colors.grey,
                ),
                onPressed: () {},
                icon: const Icon(Icons.share, size: 20),
                label: const Text('Share'),
              ),
            ],
          ),
          const Divider(color: Colors.grey),
        ],
      );

  /// "All Comments ▾" menu -> Newest / Most liked / Oldest
  Widget commentHeader() => Padding(
        key: commentsHeaderKey,
        padding: const EdgeInsets.fromLTRB(12, 6, 12, 6),
        child: Row(
          children: [
            PopupMenuButton<CommentSort>(
              tooltip: 'Sort comments',
              onSelected: (value) => setState(() => sort = value),
              itemBuilder: (context) => [
                for (final option in CommentSort.values)
                  PopupMenuItem<CommentSort>(
                    value: option,
                    child: Row(
                      children: [
                        Icon(
                          Icons.check,
                          size: 18,
                          color: option == sort
                              ? Colors.blue
                              : Colors.transparent,
                        ),
                        const SizedBox(width: 8),
                        Text(sortLabel(option)),
                      ],
                    ),
                  ),
              ],
              child: const Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'All Comments',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Icon(Icons.arrow_drop_down),
                ],
              ),
            ),
            const Spacer(),
            Text(
              sortLabel(sort),
              style: const TextStyle(
                color: Colors.grey,
                fontSize: 13,
              ),
            ),
          ],
        ),
      );

  Widget actionText(
    String label,
    VoidCallback onTap, {
    bool active = false,
  }) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 4,
          horizontal: 6,
        ),
        child: Text(
          label,
          style: TextStyle(
            fontSize: 12.5,
            fontWeight: FontWeight.bold,
            color: active ? Colors.blue : Colors.grey.shade700,
          ),
        ),
      ),
    );
  }

  /// Facebook-style comment: avatar + grey bubble, then time / Like / Reply.
  Widget commentTile(Usercomment c) => Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 12,
          vertical: 6,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CircleAvatar(
              radius: 18,
              backgroundImage: AssetImage(c.commenterImg),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 14,
                      vertical: 8,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade200,
                      borderRadius: BorderRadius.circular(18),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          c.commenterName,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 13.5,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          c.commentContent,
                          style: const TextStyle(fontSize: 14),
                        ),
                      ],
                    ),
                  ),
                  Row(
                    children: [
                      const SizedBox(width: 8),
                      Text(
                        c.timeAgo,
                        style: TextStyle(
                          fontSize: 12.5,
                          color: Colors.grey.shade700,
                        ),
                      ),
                      actionText(
                        'Like',
                        () => toggleLike(c),
                        active: c.isLiked,
                      ),
                      actionText(
                        'Reply',
                        () => replyTo(c),
                      ),
                      const Spacer(),
                      if (c.likes > 0)
                        Row(
                          children: [
                            const Icon(
                              Icons.thumb_up,
                              size: 14,
                              color: Colors.blue,
                            ),
                            const SizedBox(width: 3),
                            Text(
                              '${c.likes}',
                              style: const TextStyle(fontSize: 12.5),
                            ),
                          ],
                        ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      );

  Widget commentInput() => SafeArea(
        top: false,
        child: Container(
          padding: const EdgeInsets.fromLTRB(12, 8, 8, 8),
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.1),
                blurRadius: 6,
                offset: const Offset(0, -2),
              ),
            ],
          ),
          child: Row(
            children: [
              CircleAvatar(
                radius: 18,
                backgroundImage: AssetImage(
                  widget.userdata.myUserAccount.img,
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: TextField(
                  controller: commentController,
                  focusNode: commentFocus,
                  textInputAction: TextInputAction.send,
                  onSubmitted: (_) => addComment(),
                  decoration: InputDecoration(
                    hintText: 'Write a comment...',
                    isDense: true,
                    filled: true,
                    fillColor: Colors.grey.shade200,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
              ),
              IconButton(
                onPressed: addComment,
                icon: const Icon(
                  Icons.send,
                  color: Colors.blue,
                ),
              ),
            ],
          ),
        ),
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.grey,
          ),
        ),
        title: const Text('Post'),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              controller: scrollController,
              children: [
                userline(),
                postimage(),
                buttons(),
                commentHeader(),
                ...sortedComments.map(commentTile),
                const SizedBox(height: 12),
              ],
            ),
          ),
          commentInput(),
        ],
      ),
    );
  }
}