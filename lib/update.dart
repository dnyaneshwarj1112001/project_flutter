import 'package:flutter/material.dart';
import 'package:project_flutter/dashbord.dart';
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
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

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
      emailController.text = email;
      passwordController.text = password;
    });
  }

  Future<void> updateProfile() async {
    final updatedname = nameController.text;
    final updatedEmail = emailController.text;
    final updatedPassword = passwordController.text;

    if (updatedEmail.isEmpty || updatedPassword.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Please enter both email and password.'),
      ));
    }

    final sp = await SharedPreferences.getInstance();
    sp.setString("name", updatedname);
    sp.setString("email", updatedEmail);
    sp.setString("password", updatedPassword);
    setState(() {
      name = updatedname;
      email = updatedEmail;
      password = updatedPassword;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Update'),
      ),
      body: SingleChildScrollView(
        child: Padding(
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
                      color: Colors.grey,
                      width: 2.0,
                    ),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    children: [
                      Center(
                        child: Text(
                          'Name: $name',
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                Column(
                  children: [
                    Text("Enter Updated Email"),
                    Container(
                      width: 400,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.grey,
                          width: 2.0,
                        ),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      padding: const EdgeInsets.all(10.0),
                      child: Center(
                        child: TextFormField(
                          controller: emailController,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Column(
                  children: [
                    Text("Enter Updated Password"),
                    Container(
                      width: 400,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.grey,
                          width: 2.0,
                        ),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      padding: const EdgeInsets.all(10.0),
                      child: Center(
                        child: TextFormField(
                          controller: passwordController,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                SizedBox(
                  width: 400,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Colors.blue,
                    ),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => dashbord(),
                          ));
                    },
                    child: const Text('Update Profile'),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
