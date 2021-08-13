import 'package:bloodsquad/form/form_screen.dart';
import 'package:bloodsquad/model/user_data.dart';
import 'package:bloodsquad/widgets/imagewidget.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:bloodsquad/google_sign_in.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:bloodsquad/widgets/scardwidget.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  _ProfileState createState() => _ProfileState();
}

class Constants {
  static const String SignOut = 'Sign out';
  static const String Update = 'Update';

  static const List<String> choices = <String>[SignOut, Update];
}

class _ProfileState extends State<Profile> {
  @override
  void initState() {
    super.initState();
  }

  String? _donations;
  String? _name;
  String? _imgUrl;
  String? _bloodgroup;

  final user = FirebaseAuth.instance.currentUser!;
  CollectionReference users = FirebaseFirestore.instance.collection('users');
  // final Stream<QuerySnapshot> _usersStream =
  //    FirebaseFirestore.instance
  //       .collection('talks')
  //       .doc(user.uid)
  //       .get()
  //       .then((DocumentSnapshot ds) {
  //     // use ds as a snapshot
  //   });

  _fetch() async {
    if (user != null)
      await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .get()
          .then((ds) {
        _name = ds.data()!['userName'];
        _imgUrl = ds.data()!['imgUrl'];
        _bloodgroup = ds.data()!['bloodgroup'];
      }).catchError((e) {
        print(e);
      });
  }

  @override
  build(BuildContext context) {
    return FutureBuilder(
        future: _fetch(),
        builder: (context, futureSnapshot) {
          if (futureSnapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          return StreamBuilder(
              stream:
                  FirebaseFirestore.instance.collection('users').snapshots(),
              builder: (BuildContext context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
                // final data = snapshot.data!.docs;

                return Scaffold(
                    body: Container(
                  width: double.infinity,
                  decoration: backgroundImage(),
                  child: SafeArea(
                    child: Column(
                      children: [
                        Align(
                            alignment: Alignment.topLeft,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Align(
                                  alignment: Alignment.topLeft,
                                  child: Padding(
                                    padding: EdgeInsets.fromLTRB(10, 10, 0, 0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          'Profile',
                                          style: GoogleFonts.montserrat(
                                              fontSize: 30.sp,
                                              color: Colors.white),
                                        ),
                                        PopupMenuButton<String>(
                                          color: Colors.white,
                                          icon: FaIcon(
                                            FontAwesomeIcons.angleDoubleDown,
                                            color: Colors.white,
                                          ),
                                          iconSize: 30.sp,
                                          onSelected: choiceAction,
                                          itemBuilder: (BuildContext context) {
                                            return Constants.choices
                                                .map((String choice) {
                                              return PopupMenuItem<String>(
                                                value: choice,
                                                child: Text(choice),
                                              );
                                            }).toList();
                                          },
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                                // Align(
                                //   alignment: Alignment.topLeft,
                                //   child: Text(
                                //     'Ceylon Blood Squad',
                                //     style: GoogleFonts.montserrat(
                                //         fontSize: 20, color: Colors.white),
                                //   ),
                                // ),
                              ],
                            )),
                        CircleAvatar(
                          backgroundImage: NetworkImage(_imgUrl!),
                          radius: 70.r,
                        ),
                        Center(
                          child: Text(
                            _name!,
                            style: GoogleFonts.montserrat(
                              fontSize: 30.sp,
                              color: Colors.black,
                            ),
                          ),
                        ),
                        // child: Text(
                        //   _name!,
                        //   style: GoogleFonts.montserrat(
                        //     fontSize: 30.sp,
                        //     color: Colors.black,
                        //   ),
                        //   textAlign: TextAlign.center,
                        // ),

                        Expanded(
                          child: ListView(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  CardWidget(
                                      widget: Text(
                                        _bloodgroup!,
                                        style: GoogleFonts.montserrat(
                                          fontSize: 45.sp,
                                        ),
                                      ),
                                      text: 'Blood Groop',
                                      width: 120.w,
                                      height: 105.h),
                                  CardWidget(
                                      widget: Text(
                                        '06',
                                        style: GoogleFonts.montserrat(
                                          fontSize: 45.sp,
                                          color: Color.fromRGBO(255, 61, 92, 1),
                                        ),
                                      ),
                                      text: 'Donations',
                                      width: 120.w,
                                      height: 105.h),
                                ],
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(
                                    vertical: 8.h, horizontal: 8.w),
                                child: Center(
                                  child: Text(
                                    'Badges',
                                    style: GoogleFonts.montserrat(
                                        fontSize: 20.sp,
                                        color: Color.fromRGBO(255, 61, 92, 1)),
                                  ),
                                ),
                              ),
                              Wrap(
                                children: [
                                  CardWidget(
                                      height: 120.h,
                                      width: 120.w,
                                      widget:
                                          Image.asset('assets/badges/1.png'),
                                      text: 'Bronze'),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ));
              });
        });
  }

  void choiceAction(String choice) {
    if (choice == Constants.SignOut) {
      final provider =
          Provider.of<GoogleSignInProvider>(context, listen: false);
      provider.logout();
    }
  }
}
