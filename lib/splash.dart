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
    Timer(const Duration(seconds: 5), () {
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
      body: Center(
        child: Container(
          width: 200, // Adjust the size as needed
          height: 200, // Adjust the size as needed
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.white,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Icon(
                Icons.android, // Replace with your desired icon
                size: 100,
                color: Colors.blue, // Set the icon color
              ),
              SizedBox(height: 20),
              Text(
                "Flutter Task",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
              ),
            ],
          ),
        ),
      ),
      backgroundColor: Colors.lightBlue, // Set the background color
    );
  }
}
