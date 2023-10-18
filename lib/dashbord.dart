// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:localstorage/localstorage.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:project_flutter/profile__screen.dart';
import 'package:project_flutter/singUp.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:project_flutter/Signin.dart';

class dashbord extends StatefulWidget {
  const dashbord();
  // final String email;

  @override
  State<dashbord> createState() => _dashbordState();
}

class _dashbordState extends State<dashbord> {
  List<String> imageList1 = [
    "assets/cirimg/mb.png",
    "assets/cirimg/img3.png",
    "assets/cirimg/l2.png",
    "assets/cirimg/dgm.png",
    "assets/cirimg/img4.png",
    "assets/cirimg/img5.png",
  ];

  List<String> imageList2 = [
    "assets/coursesimg/img1.png",
    "assets/coursesimg/img2.png",
    "assets/coursesimg/img4.png",
    "assets/coursesimg/img5.png",
  ];

  final LocalStorage storage = LocalStorage('signin_data');
  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    await storage.ready;
    final storedData = storage.getItem('credentials');
    print(storedData);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: ListView(
          children: <Widget>[
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Text(
                'Menu',
                style: TextStyle(fontSize: 24, color: Colors.white),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.dashboard),
              title: const Text('Dashboard'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.login),
              title: const Text('Sign In'),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SignInPage(),
                    ));
              },
            ),
            ListTile(
              leading: const Icon(Icons.person_add),
              title: const Text('Sign Up'),
              onTap: () {
                PersistentNavBarNavigator.pushNewScreen(
                  context,
                  screen: SignInPage(),
                  withNavBar: false,
                  pageTransitionAnimation: PageTransitionAnimation.cupertino,
                );
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SignUpPage(),
                    ));
              },
            ),
            ListTile(
              leading: const Icon(Icons.account_circle),
              title: const Text('Profile'),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ProfilePage(),
                    ));
              },
            ),
          ],
        ),
      ),
      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
        title: const Text(
          "Dashboard",
        ),
        actions: [
          IconButton(
              icon: const Icon(Icons.logout),
              onPressed: () async {
                final prefs = await SharedPreferences.getInstance();
                await prefs.setBool('isAuthenticated', false);

                PersistentNavBarNavigator.pushNewScreen(
                  context,
                  screen: SignInPage(),
                  withNavBar: false,
                  pageTransitionAnimation: PageTransitionAnimation.cupertino,
                );
              })
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: Column(
                  children: [
                    const Text(
                      "Horizontal Image List ->",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                    ),
                    SizedBox(
                      height: 200.00,
                      child: ListView.builder(
                        itemCount: imageList2.length,
                        scrollDirection: Axis.horizontal,
                        shrinkWrap: true,
                        itemBuilder: (BuildContext context, int index) {
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ClipRRect(
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(10)),
                              child: Image.asset(
                                imageList2[index],
                                width: 300,
                                fit: BoxFit.cover,
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
              Column(
                children: [
                  Column(
                    children: [
                      const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          "Verticle images ->",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 18),
                        ),
                      ),
                      SizedBox(
                        child: ListView.builder(
                          itemCount: imageList2.length,
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemBuilder: (BuildContext context, int index) {
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: ClipRRect(
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(10)),
                                child: Image.asset(
                                  imageList2[index],
                                  width: MediaQuery.of(context).size.width,
                                  height: 200.00,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              Column(
                children: [
                  // ignore: prefer_const_constructors

                  Column(
                    children: [
                      const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          "Grid Images ",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 18),
                        ),
                      ),
                      SizedBox(
                        child: GridView.builder(
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                          ),
                          itemCount: imageList2.length,
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemBuilder: (BuildContext context, int index) {
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: ClipRRect(
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(10)),
                                child: Image.asset(
                                  imageList2[index],
                                  width: MediaQuery.of(context).size.width,
                                  height: 200.00,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
