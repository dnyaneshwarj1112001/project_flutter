import 'package:flutter/material.dart';
import 'package:localstorage/localstorage.dart';
import 'package:project_flutter/base_screen.dart';
import 'package:project_flutter/dashbord.dart';
import 'package:project_flutter/singUp.dart';
import 'package:project_flutter/update.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignInPage extends StatefulWidget {
  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _emailController = TextEditingController();

  final TextEditingController _passwordController = TextEditingController();

  final storage = LocalStorage('my_app');
  // You can choose any identifier
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

  bool isErrorForEmail = false;

  bool isErrorForPass = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sign In'),
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
                decoration: const InputDecoration(
                    labelText: 'Email', border: OutlineInputBorder()),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your email';
                  }
                  // You can add more specific email validation here if needed
                  return null;
                },
              ),
              const SizedBox(height: 20), // Add spacing
              TextFormField(
                controller: _passwordController,
                decoration: InputDecoration(
                    errorBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: isErrorForEmail ? Colors.red : Colors.grey,
                      ), // Set the border color to red
                    ),
                    labelText: 'Password',
                    border: const OutlineInputBorder()),
                obscureText: true,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your password';
                  }

                  return null;
                },
              ),
              SizedBox(height: 20),
              SizedBox(
                width: 400,
                height: 50,
                child: ElevatedButton(
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      final storedCredentials = await getStoredCredentials();
                      final enteredEmail = _emailController.text;
                      final enteredPassword = _passwordController.text;

                      if (enteredEmail != storedCredentials['email']) {
                        setState(() {
                          isErrorForEmail = true;
                        });
                        print(isErrorForEmail);
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            backgroundColor: Colors.red,
                            content: Text('Your email is incorrect '),
                          ),
                        );
                      } else if (enteredPassword !=
                          storedCredentials['password']) {
                        setState(() {
                          isErrorForPass = true;
                        });
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            backgroundColor: Colors.red,
                            content: Text('Your password is wrong !'),
                          ),
                        );
                      } else {
                        final prefs = await SharedPreferences.getInstance();
                        await prefs.setBool('isAuthenticated', true);
                        await prefs.setString('email', enteredEmail);
                        await prefs.setString('password', enteredPassword);
                        setState(() {
                          isErrorForPass = false;
                          isErrorForPass = false;
                        });
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const BaseScreen(),
                            ));
                      }
                    }
                  },
                  child: Text(
                    'Sign In',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white, // Text color
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              ElevatedButton(
                onPressed: () {},
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.blue),
                  padding:
                      MaterialStateProperty.all(const EdgeInsets.all(16.0)),
                  textStyle: MaterialStateProperty.all(
                    const TextStyle(
                      color: Colors.white,
                      fontSize: 18.0,
                    ),
                  ),
                  shape: MaterialStateProperty.all(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                ),
                child: const Row(
                  children: [
                    Icon(
                      Icons.facebook,
                      color: Colors.white,
                    ),
                    SizedBox(
                        width: 10), // Add some space between the icon and text
                    Padding(
                      padding: EdgeInsets.only(left: 40),
                      child: Text('Login with Facebook'),
                    ),
                  ],
                ),
              ),

              TextButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ProfilePage(),
                      ));
                },
                child: const Text('Forgot Password?'),
              ),
              TextButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const SignUpPage()));
                },
                child: const Text('Create an Account'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
