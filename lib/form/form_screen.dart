import 'package:bloodsquad/form/form.dart';
import 'package:bloodsquad/mainpage.dart';
import 'package:bloodsquad/screens/dashboard.dart';
import 'package:bloodsquad/screens/home.dart';
import 'package:bloodsquad/screens/profile.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class FormScreen extends StatefulWidget {
  @override
  _FormScreenState createState() => _FormScreenState();
}

class _FormScreenState extends State<FormScreen> {
  var _isLoading = false;
  // User? user = FirebaseAuth.instance.currentUser;
  final _auth = FirebaseAuth.instance;

  firebase_storage.FirebaseStorage storage =
      firebase_storage.FirebaseStorage.instance;

  void _submitAuthForm(
      String name,
      String email,
      String password,
      // String confirmPassword,
      String contactNo,
      String district,
      // String city,
      String height,
      String weight,
      String bloodgroup,
      File pickImage,
      BuildContext ctx) async {
    try {
      setState(() {
        _isLoading = true;
      });
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);

      firebase_storage.Reference ref = firebase_storage.FirebaseStorage.instance
          .ref()
          .child('user_image')
          .child(userCredential.user.toString());
      await ref
          .putFile(pickImage)
          .whenComplete(() => Navigator.pop(context, MainPage()));
      final url = await ref.getDownloadURL();

      FirebaseFirestore.instance
          .collection('users')
          .doc(userCredential.user!.uid)
          .set({
        'userName': name,
        'userId': email,
        'contactNo': contactNo,
        'district': district,
        // 'city': city,
        'height': height,
        'weight': weight,
        'bloodgroup': bloodgroup,
        'imgUrl': url,
      });
      setState(() {
        _isLoading = false;
      });
    } catch (e) {
      ScaffoldMessenger.of(ctx).showSnackBar(
        const SnackBar(
          content: Text('Pleas pick an image'),
        ),
      );

      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return RegForm(_submitAuthForm, _isLoading);
  }
}
