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
  Userdata userdata = Userdata();

  var followTxtStyle = const TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.bold,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back),
        ), // IconButton
      ), // AppBar
      body: ListView(
        shrinkWrap: true,
        children: [
          Mainheader(userdata: userdata),
          Infoheader(userdata: userdata),
          Friendlist(userdata: userdata),
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: Row(children: [Text('Posts', style: followTxtStyle)]),
          ), // Padding
          const SizedBox(height: 20),
          Postlist(userdata: userdata),
        ],
      ), // ListView
    ); // Scaffold
  }
}