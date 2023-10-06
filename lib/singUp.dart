import 'package:flutter/material.dart';
import 'package:localstorage/localstorage.dart';
import 'package:project_flutter/base_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:project_flutter/Signin.dart';

import 'dashbord.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _nameController = TextEditingController();

  final TextEditingController _emailController = TextEditingController();

  final TextEditingController _passwordController = TextEditingController();

  final TextEditingController _confirmPasswordController =
      TextEditingController();

  final storage = LocalStorage('my_app');
  // You can choose any identifier
  Future<void> storeCredentials(
      String name, String email, String password) async {
    final dataToStore = {
      'name': name,
      'email': email,
      'password': password,
    };
    await storage.ready;
    await storage.setItem('credentials', dataToStore);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Register'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextFormField(
                controller: _nameController,
                decoration: InputDecoration(
                    labelText: 'Name', border: OutlineInputBorder()),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your name';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              TextFormField(
                controller: _emailController,
                decoration: InputDecoration(
                    labelText: 'Email', border: OutlineInputBorder()),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your email';
                  }
                  // You can add more specific email validation here if needed
                  return null;
                },
              ),
              SizedBox(height: 20),
              TextFormField(
                controller: _passwordController,
                decoration: InputDecoration(
                    labelText: 'Password', border: OutlineInputBorder()),
                obscureText: true,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your password';
                  }
                  // Add more password validation logic if required
                  return null;
                },
              ),
              SizedBox(height: 20),
              TextFormField(
                controller: _confirmPasswordController,
                decoration: InputDecoration(
                    labelText: 'Confirm Password',
                    border: OutlineInputBorder()),
                obscureText: true,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please confirm your password';
                  }
                  if (value != _passwordController.text) {
                    return 'Passwords do not match';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    final enteredName = _nameController.text;
                    final enteredEmail = _emailController.text;
                    final enteredPassword = _passwordController.text;

                    // Store user credentials (you can add more validation if needed)
                    await storeCredentials(
                        enteredName, enteredEmail, enteredPassword);
                    final prefs = await SharedPreferences.getInstance();

                    await prefs.setString('email', enteredEmail);
                    // Registration successful, you can navigate to another screen or show a success message
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Registration successful.'),
                      ),
                    );
                    final sp = await SharedPreferences.getInstance();
                    await sp.setBool('isAuthenticated', true);
                     await sp.setString('email', enteredEmail);
                      await sp.setString('password', enteredPassword);
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => BaseScreen(),
                        ));
                  }
                },
                child: Text('SignUp'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
