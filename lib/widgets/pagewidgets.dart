//Dart2.9;
import 'package:bloodsquad/model/user_data.dart';
import 'package:bloodsquad/widgets/getimg.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class MainTitle extends StatelessWidget {
  String _title = '';
  //String _subTitle = '';
  MainTitle(
    _title,
  ) {
    this._title = _title;
//this._subTitle = _subTitle;
  }
  String? url;

  // getUrl() async {

  // //   if (user != null)
  //     await FirebaseFirestore.instance
  //         .collection('users')
  //         .doc(user.uid)
  //         .get()
  //         .then((ds) {

  //     }).catchError((e) {
  //       print(e);
  //     });
  // }
  final user = FirebaseAuth.instance.currentUser!;
  @override
  Widget build(BuildContext context) {
    // FutureBuilder(
    //     future:
    //         FirebaseFirestore.instance.collection('users').doc(user.uid).get(),
    //     builder: (context, futureSnapshot) {
    //       if (futureSnapshot.connectionState == ConnectionState.waiting) {
    //         return Center(
    //           child: CircularProgressIndicator(),
    //         );
    //       }
    //       if (!futureSnapshot.hasData) {}
    //final data = futureSnapshot.requireData;
    //final data= futureSnapshot.data!.data[''];
    // get() async {
    //   return url = await data!.data['imgUrl'];
    // }

    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Padding(
                  padding: EdgeInsets.fromLTRB(0, 3.h, 10.w, 0),
                  child: Container(
                    height: 40,
                    // child: CircleAvatar(
                    //   backgroundImage: NetworkImage(
                    //       'https://img.icons8.com/office/16/000000/test-account.png'),
                    //   radius: 20,
                    // ),
                  ),
                ),
              ],
            ),
            Text(
              _title,
              style:
                  GoogleFonts.montserrat(fontSize: 40.sp, color: Colors.white),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(0, 5.h, 0, 0),
              child: Text(
                'Give a drop save a life',
                style: GoogleFonts.montserrat(
                    fontSize: 20.sp, color: Colors.white),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
