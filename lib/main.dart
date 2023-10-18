import 'package:flutter/material.dart';
import 'package:project_flutter/Signin.dart';
import 'package:project_flutter/base_screen.dart';
import 'package:project_flutter/splash.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: false,
      ),
      home: Splash(),
    );
  }
}
