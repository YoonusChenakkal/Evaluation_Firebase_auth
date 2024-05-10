import 'package:evaluationfirebaseauth/loginPage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class home extends StatelessWidget {
  const home({super.key});

  signOut(BuildContext context) async {
    await FirebaseAuth.instance.signOut();

    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove('email');
    prefs.remove('password');
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (context) => loginPage(),
      ),
      (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: ElevatedButton(
          onPressed: () {
            signOut(context);
          },
          child: Text('Sign Out')),
      body: Center(
          child: Text(
        'Loged In Successfully',
        style: TextStyle(fontSize: 40),
      )),
    );
  }
}
