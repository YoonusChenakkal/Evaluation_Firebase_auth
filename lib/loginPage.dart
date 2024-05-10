import 'package:evaluationfirebaseauth/home.dart';
import 'package:evaluationfirebaseauth/signUpScreen.dart';
import 'package:evaluationfirebaseauth/text_Field.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class loginPage extends StatelessWidget {
  loginPage({super.key});
  TextEditingController tc_email = TextEditingController();
  TextEditingController tc_pass = TextEditingController();
  signIn(BuildContext context) async {
    try {
      final UserCredential userCredential =
          await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: tc_email.text,
        password: tc_pass.text,
      );
      final User? user = userCredential.user;
      if (user != null) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Sign in Successfully'),
          duration: Duration(seconds: 2),
        ));
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => home(),
            ));
      }
    } on FirebaseAuthException catch (e) {
      print(e.code);
      if (e.code == 'user-not-found') {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('No user found for that email'),
          duration: Duration(seconds: 2),
        ));
      } else if (e.code == 'wrong-password') {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Wrong password provided for that user'),
          duration: Duration(seconds: 2),
        ));
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('wrong Details'),
          duration: Duration(seconds: 2),
        ));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        color: Colors.red,
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
            ElevatedButton(onPressed: () {
              signIn(context);
            }, child: Text('login')),
            SizedBox(
              height: 20,
            ),
            TextButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => signUpScreen(),
                      ));
                },
                child: Text('Sign Up'))
          ],
        ),
      ),
    );
  }
}
