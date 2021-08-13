import 'package:flutter/material.dart';
import 'widgets/loginform.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'screens/home.dart';

class LoginPage extends StatelessWidget {
  final _auth = FirebaseAuth.instance;
  void _submitAuthForm(
    String? email,
    String? password,
  ) async {
    await _auth.signInWithEmailAndPassword(email: email!, password: password!);
  }

  @override
  Widget build(BuildContext context) => LogingWidget(_submitAuthForm);
}
