import 'package:flutter/material.dart';
import '../models/friend.dart';
import '../models/userdata.dart';

// ignore: must_be_immutable
class Friendlist extends StatelessWidget {
  Friendlist({super.key, required this.userdata});

  final Userdata userdata;

  var followTxtStyle = const TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.bold,
  );

  Widget friend(Friend friend) => Card(
        child: Column(
          children: [
            Expanded(child: Image.asset(friend.img)),
            Padding(padding: const EdgeInsets.all(8.0), child: Text(friend.name)),
          ],
        ), // Column
      ); // Card

  Widget friendsListGrid() => GridView.builder(
        shrinkWrap: true,
        physics: const BouncingScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          mainAxisExtent: 180,
        ), // SliverGridDelegateWithFixedCrossAxisCount
        itemCount: userdata.friendList.length,
        itemBuilder: (BuildContext ctx, index) {
          return friend(userdata.friendList[index]);
        },
      ); // GridView.builder

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 10),
        Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: Row(children: [Text('Friends', style: followTxtStyle)]),
        ), // Padding
        Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: Row(children: [Text('${userdata.friendList.length} Friends')]),
        ), // Padding
        const SizedBox(height: 10),
        SizedBox(height: 380, child: friendsListGrid()),
        SizedBox(height: 10, child: Container(color: Colors.grey)),
      ],
    ); // Column
  }
}