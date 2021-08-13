import 'package:bloodsquad/screens/home.dart';
import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class News extends StatefulWidget {
  const News({Key? key}) : super(key: key);

  @override
  _NewsState createState() => _NewsState();
}

class _NewsState extends State<News> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, 'home');
            },
            icon: Icon(Icons.arrow_back),
          ),
          title: Padding(
            padding: EdgeInsets.symmetric(
              vertical: 8.h,
            ),
            child: Text('Newsfeed',
                style: GoogleFonts.montserrat(fontSize: 30.sp)),
          ),
          bottom: TabBar(isScrollable: false, tabs: [
            Tab(
              text: "Emergency",
              icon: Icon(Icons.wb_twilight_sharp),
            ),
            Tab(
              text: "Other",
              icon: Icon(Icons.health_and_safety),
            ),
          ]),
        ),
      ),
    );
  }
}
