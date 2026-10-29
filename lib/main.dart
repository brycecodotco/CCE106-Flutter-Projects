import 'package:flutter/material.dart';
import 'package:labtasks/alignmentDemo.dart';
import 'package:labtasks/edgeAct.dart';
import 'pavlova.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: AlignmentDemo(),
    );
  }
}