import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  String name = "";
  String email = "";
  String password = "";

  @override
  void initState() {
    super.initState();
    getUserByEmail();
  }

  Future<void> getUserByEmail() async {
    final sp = await SharedPreferences.getInstance();
    setState(() {
      name = sp.getString("name") ?? "";
      email = sp.getString("email") ?? "";
      password = sp.getString("password") ?? "";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                width: 200,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.grey, // Border color
                    width: 2.0, // Border width
                  ),
                  borderRadius: BorderRadius.circular(10.0), // Rounded corners
                ),
                padding: const EdgeInsets.all(10.0), // Padding inside the container
                child: Center(
                  child: Text(
                    'Name: $name',
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Container(
                width: 200,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.grey, // Border color
                    width: 2.0, // Border width
                  ),
                  borderRadius: BorderRadius.circular(10.0), // Rounded corners
                ),
                padding: const EdgeInsets.all(10.0), // Padding inside the container
                child: Center(
                  child: Text(
                    'Email: $email',
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Container(
                width: 200,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.grey, // Border color
                    width: 2.0, // Border width
                  ),
                  borderRadius: BorderRadius.circular(10.0), // Rounded corners
                ),
                padding: const EdgeInsets.all(10.0), // Padding inside the container
                child: Center(
                  child: Text(
                    'Password: $password',
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
