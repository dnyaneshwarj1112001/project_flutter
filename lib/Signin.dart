import 'package:flutter/material.dart';
import 'package:localstorage/localstorage.dart';
import 'package:project_flutter/base_screen.dart';
import 'package:project_flutter/dashbord.dart';
import 'package:project_flutter/singUp.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignInPage extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final storage = LocalStorage('my_app'); // You can choose any identifier

//   Storing user credentials
  Future<void> storeCredentials(String email, String password) async {
    final dataToStore = {
      'email': email,
      'password': password,
    };
    await storage.ready;
    await storage.setItem('credentials', dataToStore);
  }

// Retrieving user credentials
  Future<Map<String, dynamic>> getStoredCredentials() async {
    await storage.ready;
    final storedData = storage.getItem('credentials');
    return storedData ?? {};
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sign In'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0), // Add padding
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
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
              SizedBox(height: 20), // Add spacing
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
              SizedBox(height: 20), // Add spacing
              ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    final storedCredentials = await getStoredCredentials();
                    final enteredEmail = _emailController.text;
                    final enteredPassword = _passwordController.text;
                    print(storedCredentials);

                    if (enteredEmail == storedCredentials['email'] &&
                        enteredPassword == storedCredentials['password']) {
                      final prefs = await SharedPreferences.getInstance();
                      await prefs.setBool('isAuthenticated', true);
                      await prefs.setString('email', enteredEmail);
                      await prefs.setString('password', enteredPassword);
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => BaseScreen(),
                          ));
                      // ScaffoldMessenger.of(context).showSnackBar(
                      //   SnackBar(
                      //     content: Text('Login Successful'),
                      //   ),
                      // );
                    } else {
                      // Invalid credentials; show an error message
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Invalid email or password.'),
                        ),
                      );
                    }
                  }
                },
                child: Text('Sign In'),
              ),

              TextButton(
                onPressed: () {
                  // Navigate to the forgot password page
                },
                child: Text('Forgot Password?'),
              ),
              TextButton(
                onPressed: () {
                  // Navigate to the sign-up page
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => SignUpPage()));
                },
                child: Text('Create an Account'),
              ),
              IconButton(
                onPressed: () {},
                icon: Icon(Icons.facebook),
              )
            ],
          ),
        ),
      ),
    );
  }
}
