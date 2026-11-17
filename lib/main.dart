import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:labtasks/Lab Task 8/HomePage.dart';
import 'package:labtasks/Lab Task 7/auth/login.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Firebase CRUD',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.teal),
      ),
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}