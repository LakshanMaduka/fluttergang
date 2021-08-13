import 'package:bloodsquad/db_icons.dart';
import 'package:bloodsquad/widgets/pagewidgets.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:google_fonts/google_fonts.dart';

class Dashboard extends StatefulWidget {
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  final user = FirebaseAuth.instance.currentUser!;
  CollectionReference users = FirebaseFirestore.instance.collection('users');

  String? _height;
  String? _weight;
  String? _bloodgroup;
  _fetch() async {
    if (user != null)
      await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .get()
          .then((ds) {
        _height = ds.data()!['height'];
        _weight = ds.data()!['weight'];
        _bloodgroup = ds.data()!['bloodgroup'];
      }).catchError((e) {
        print(e);
      });
  }

  Dashboard ds = new Dashboard();
  String calculateBmi() {
    double height = double.parse(_height!) / 100;
    double weight = double.parse(_weight!);
    double bmi = weight / (height * height);

    return bmi.toStringAsFixed(1);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _fetch(),
        builder: (context, futureSnapshot) {
          if (futureSnapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          return Scaffold(
            body: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: ExactAssetImage('assets/images/login.png'),
                  fit: BoxFit.cover,
                  alignment: Alignment.topCenter,
                ),
              ),
              child: SafeArea(
                child: Column(
                  children: [
                    SizedBox(
                      height: 10.h,
                    ),
                    MainTitle('Dashboard'),
                    SizedBox(
                      height: 80.h,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CardWidgetD(
                            image1: Icon(MyFlutter.water_drop,
                                size: 50,
                                color: Color.fromRGBO(255, 83, 122, 1)),
                            widget: Container(
                              padding: EdgeInsets.fromLTRB(0, 12.h, 0, 12.h),
                              child: Text(
                                _bloodgroup!,
                                style: GoogleFonts.montserrat(
                                  fontSize: 45.sp,
                                ),
                              ),
                            ),
                            text: "Blood Group"),
                        CardWidgetD(
                            image1: Icon(MyFlutter.scale,
                                size: 50,
                                color: Color.fromRGBO(255, 83, 122, 1)),
                            widget: Container(
                              padding: EdgeInsets.fromLTRB(0, 12.h, 0, 12.h),
                              child: Text(
                                _weight! + '\nKg',
                                textAlign: TextAlign.center,
                                style: TextStyle(fontSize: 25.sp),
                              ),
                            ),
                            text: "Weight"),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CardWidgetD(
                            image1: Icon(MyFlutter.height,
                                size: 50,
                                color: Color.fromRGBO(255, 83, 122, 1)),
                            widget: Container(
                              padding: EdgeInsets.fromLTRB(0, 12.h, 0, 12.h),
                              child: Text(
                                _height! + '\n cm',
                                textAlign: TextAlign.center,
                                style: TextStyle(fontSize: 25.sp),
                              ),
                            ),
                            text: "Height"),
                        CardWidgetD(
                            image1: Icon(MyFlutter.bmi,
                                size: 50,
                                color: Color.fromRGBO(255, 83, 122, 1)),
                            widget: Padding(
                              padding: EdgeInsets.fromLTRB(0, 12.h, 0, 10.h),
                              child: Column(
                                children: [
                                  Text(
                                    calculateBmi(),
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontSize: 25.sp, height: 1.5.h),
                                  ),
                                  Icon(
                                    Icons.wb_sunny_sharp,
                                    color: double.parse(calculateBmi()) <
                                                18.5 ||
                                            double.parse(calculateBmi()) > 25
                                        ? Colors.red
                                        : Colors.green,
                                  ),
                                ],
                              ),
                            ),
                            text: "BMI"),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }
}

Widget CardWidgetD(
    {required Widget image1, required Widget widget, required String text}) {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 8.w),
    child: Card(
      elevation: 10,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: Container(
        width: 140.w,
        height: 125.h,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  image1,
                  Container(
                    child: widget,
                  )
                ],
              ),
              Text(
                text,
                style: GoogleFonts.montserrat(fontSize: 16.sp),
              ),
            ],
          ),
        ),
      ),
    ),
  );
}
