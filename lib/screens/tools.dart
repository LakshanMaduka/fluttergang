import 'package:bloodsquad/db_icons.dart';
import 'package:bloodsquad/widgets/pagewidgets.dart';
import 'package:bloodsquad/widgets/scardwidget.dart';
import 'package:flutter/material.dart';
import 'package:bloodsquad/widgets/imagewidget.dart';
import 'package:bloodsquad/widgets/sdcard2.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';

class ToolsPage extends StatelessWidget {
  const ToolsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      width: double.infinity,
      decoration: backgroundImage(),
      child: Column(
        children: [
          MainTitle('Menu'),
          SizedBox(
            height: 100.h,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.of(context).pushNamed('history');
                },
                child: CardWidget2(
                    widget: Icon(
                      Icons.history,
                      size: 60.sp,
                      color: Color.fromRGBO(255, 61, 92, 0.8),
                    ),
                    text: 'History',
                    height: 120.h,
                    width: 150.w),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.of(context).pushNamed('emergency');
                },
                child: CardWidget2(
                    widget: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: Icon(
                        MyFlutter.telephone,
                        size: 40.sp,
                        color: Color.fromRGBO(255, 61, 92, 0.8),
                      ),
                    ),
                    text: 'Emergency',
                    height: 120.h,
                    width: 150.w),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.of(context).pushNamed('Bmi');
                },
                child: CardWidget2(
                    widget: Icon(
                      MyFlutter.bmi,
                      size: 60.sp,
                      color: Color.fromRGBO(255, 61, 92, 0.8),
                    ),
                    text: 'BMI',
                    height: 120.h,
                    width: 150.w),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.of(context).pushNamed('friends');
                },
                child: CardWidget2(
                    widget: Icon(
                      MyFlutter.friend,
                      size: 60.sp,
                      color: Color.fromRGBO(255, 61, 92, 0.8),
                    ),
                    text: 'Friends',
                    height: 120.h,
                    width: 150.w),
              ),
            ],
          )
        ],
      ),
    ));
  }
}
