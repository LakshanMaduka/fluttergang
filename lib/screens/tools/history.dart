import 'package:flutter/material.dart';
import 'package:bloodsquad/widgets/pagewidgets.dart';
import 'package:bloodsquad/widgets/imagewidget.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class History extends StatelessWidget {
  const History({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Scaffold(
      body: Container(
          width: double.infinity,
          decoration: backgroundImage(),
          child: Column(children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 30),
              child: Align(
                alignment: Alignment.topLeft,
                child: IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: Icon(
                    Icons.arrow_back,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            MainTitle('History'),
            Card(
              elevation: 10,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.r),
              ),
              child: InkWell(
                child: Container(
                  width: double.infinity,
                  height: 100,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'Donated',
                        style: GoogleFonts.montserrat(fontSize: 30.sp),
                        textAlign: TextAlign.center,
                      ),
                      Text(
                        'Location: Galle BloodBank\n Time: 12.00pm',
                        style: GoogleFonts.montserrat(fontSize: 15.sp),
                        textAlign: TextAlign.center,
                      )
                    ],
                  ),
                ),
              ),
            ),
          ])),
    ));
  }
}
