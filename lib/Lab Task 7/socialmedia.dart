import 'package:flutter/material.dart';

import 'package:labtasks/Lab Task 7/models/userdata.dart';
import 'package:labtasks/Lab Task 7/views/friendlist.dart';
import 'package:labtasks/Lab Task 7/views/infoheader.dart';
import 'package:labtasks/Lab Task 7/views/mainheader.dart';
import 'package:labtasks/Lab Task 7/views/postlist.dart';

class Socialmedia extends StatefulWidget {
  const Socialmedia({super.key});

  @override
  State<Socialmedia> createState() => _SocialmediaState();
}

class _SocialmediaState extends State<Socialmedia> {
  // Created once here (not in build) so comments survive rebuilds.
  final Userdata userdata = Userdata();
  bool loaded = false;

  static const followTxtStyle = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.bold,
  );

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    await userdata.loadComments(); // restore saved comments
    if (mounted) setState(() => loaded = true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back),
        ),
      ),
      body: !loaded
          ? const Center(child: CircularProgressIndicator())
          // ONE scrollable for the whole screen. Inner lists/grids use
          // shrinkWrap + NeverScrollableScrollPhysics, so there is no
          // "unbounded height" error and no nested-scroll fighting.
          : ListView(
              children: [
                Mainheader(userdata: userdata),
                Infoheader(userdata: userdata),
                Friendlist(userdata: userdata),
                const SizedBox(height: 20),
                const Padding(
                  padding: EdgeInsets.only(left: 8.0),
                  child: Row(children: [Text('Posts', style: followTxtStyle)]),
                ),
                const SizedBox(height: 20),
                Postlist(
                  userdata: userdata,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                ),
                const SizedBox(height: 20),
              ],
            ),
    );
  }
}