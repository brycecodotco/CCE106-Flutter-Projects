import 'package:flutter/material.dart';
import 'package:labtasks/Lab Task 5/alignmentDemo.dart';
import 'package:labtasks/Lab Task 4/edgeAct.dart';
import 'package:labtasks/Lab Task 6/login.dart';
import 'package:labtasks/Lab Task 3/pavlova.dart';
import 'package:labtasks/Lab Task 7/auth/login.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Flutter Demo",
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      debugShowCheckedModeBanner: false,
      home: LoginForm(),
    );
  }
}