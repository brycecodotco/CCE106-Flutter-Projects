import 'package:flutter/material.dart';

import '../models/friend.dart';
import '../models/userdata.dart';

class Friendlist extends StatelessWidget {
  const Friendlist({super.key, required this.userdata});

  final Userdata userdata;

  static const followTxtStyle = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.bold,
  );

  Widget friend(Friend friend) => Card(
        clipBehavior: Clip.antiAlias,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Every photo fills the same box, whatever its aspect ratio.
            Expanded(
              child: Image.asset(
                friend.img,
                fit: BoxFit.cover,
                alignment: Alignment.topCenter,
                errorBuilder: (_, __, ___) => Container(
                  color: Colors.grey.shade300,
                  child: const Icon(Icons.person, color: Colors.grey),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 8),
              child: Text(
                friend.name,
                textAlign: TextAlign.center,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      );

  Widget friendsListGrid() => GridView.builder(
        // Sizes itself to its rows and lets the parent do the scrolling,
        // so there is no fixed height to clip or leave a gap.
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        padding: const EdgeInsets.symmetric(horizontal: 8),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          mainAxisExtent: 180,
          crossAxisSpacing: 4,
          mainAxisSpacing: 4,
        ),
        itemCount: userdata.friendList.length,
        itemBuilder: (_, index) => friend(userdata.friendList[index]),
      );

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 10),
        const Padding(
          padding: EdgeInsets.only(left: 8.0),
          child: Text('Friends', style: followTxtStyle),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 8.0, bottom: 10),
          child: Text('${userdata.friendList.length} Friends'),
        ),
        friendsListGrid(),
        const SizedBox(height: 10),
        Container(height: 10, color: Colors.grey),
      ],
    );
  }
}