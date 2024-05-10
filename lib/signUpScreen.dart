import 'package:evaluationfirebaseauth/home.dart';
import 'package:evaluationfirebaseauth/loginPage.dart';
import 'package:evaluationfirebaseauth/text_Field.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

class signUpScreen extends StatelessWidget {
  signUpScreen({super.key});
  TextEditingController tc_email = TextEditingController();
  TextEditingController tc_pass = TextEditingController();
  setUser() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('email', tc_email.text);
    await prefs.setString('password', tc_pass.text);
  }

  signUp(BuildContext context) async {
    try {
      final UserCredential userCredential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: tc_email.text,
        password: tc_pass.text,
      );
      final User? user = userCredential.user;
      if (user != null) {
        // set user to shared preference
        setUser();
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => home(),
            ));
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('User creation failed.'),
          duration: Duration(seconds: 2),
        ));
      }
      ;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('The password provided is too weak.'),
          duration: Duration(seconds: 2),
        ));
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('The account already exists for that email.'),
          duration: Duration(seconds: 2),
        ));
        print('The account already exists for that email.');
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(e.toString()),
        duration: Duration(seconds: 2),
      ));
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        color: Colors.green,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            text_field(
                controller: tc_email,
                title: 'Email',
                width: 300,
                keyboardType: TextInputType.emailAddress),
            SizedBox(
              height: 20,
            ),
            text_field(
                controller: tc_pass,
                title: 'Password',
                width: 300,
                keyboardType: TextInputType.emailAddress),
            SizedBox(
              height: 20,
            ),
            ElevatedButton(
                onPressed: () {
                  signUp(context);
                },
                child: Text('Sign_Up')),
            SizedBox(
              height: 20,
            ),
            TextButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => loginPage()));
                },
                child: Text('LOGIN'))
          ],
        ),
      ),
    );
  }
}
