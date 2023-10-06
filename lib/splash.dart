import 'dart:async';

import 'package:flutter/material.dart';
import 'package:project_flutter/Signin.dart';
import 'package:project_flutter/base_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Splash extends StatefulWidget {
  const Splash({Key? key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 1), () {
      checkAuthenticationStatus();
    });
  }

  checkAuthenticationStatus() async {
    final prefs = await SharedPreferences.getInstance();
    bool status = prefs.getBool('isAuthenticated') ?? false;
    if (status == true) {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => BaseScreen()));
    } else {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => SignInPage()));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Added '(' to open the function call
      body: Center(
        child: Text("Flutter Task"), // Fixed 'hild' to 'child'
      ), // Added ')' to close the function call
    );
  }
}
