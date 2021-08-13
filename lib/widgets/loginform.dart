import 'package:bloodsquad/google_sign_in.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:bloodsquad/widgets/imagewidget.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class LogingWidget extends StatefulWidget {
  LogingWidget(this.submitFn);
  void Function(
    String? _email,
    String? _password,
  ) submitFn;

  @override
  _LogingWidgetState createState() => _LogingWidgetState();
}

class _LogingWidgetState extends State<LogingWidget> {
  @override
  Widget build(BuildContext context) {
    String _email = "";
    String _password = "";
    final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
    void _tryLogin() {
      final isValid = _formKey.currentState!.validate();
      FocusScope.of(context).unfocus();
      if (isValid) {
        _formKey.currentState!.save();
        widget.submitFn(
          _email.trim(),
          _password.trim(),
        );
      }
    }

    return Scaffold(
      body: Container(
        decoration: backgroundImage(),
        child: Column(
          children: [
            SizedBox(height: 50.h),
            Padding(
              padding: EdgeInsets.symmetric(
                vertical: 20.h,
              ),
              child: SizedBox(
                height: 100.h,
                child: Container(
                  child: Image.asset("assets/images/logo2.png",
                      fit: BoxFit.contain),
                ),
              ),
            ),
            SizedBox(
              height: 20.h,
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(0, 5.h, 0, 10.h),
              child: Text("Welcome!",
                  style: GoogleFonts.montserrat(
                    color: Color.fromRGBO(13, 21, 41, 1),
                    fontSize: 40.sp,
                  )),
            ),
            Text("Donate a drop and save lives",
                style: GoogleFonts.montserrat(
                  color: Color.fromRGBO(13, 21, 41, 1),
                  fontSize: 20.sp,
                )),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(
                          vertical: 40.h, horizontal: 40.w),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10.r),
                          boxShadow: [
                            BoxShadow(
                                color: Color.fromRGBO(186, 186, 186, .2),
                                blurRadius: 20.r,
                                offset: Offset(0, 10))
                          ],
                        ),
                        child: Form(
                          key: _formKey,
                          child: Column(
                            children: [
                              Column(
                                children: <Widget>[
                                  Container(
                                    padding: EdgeInsets.symmetric(
                                        vertical: 10.h, horizontal: 10.w),
                                    decoration: BoxDecoration(
                                        border: Border(
                                            bottom: BorderSide(
                                                color: Colors.grey.shade200))),
                                    child: TextFormField(
                                      decoration: InputDecoration(
                                          hintText: "Email or Phone number",
                                          hintStyle:
                                              TextStyle(color: Colors.grey),
                                          border: InputBorder.none),
                                      validator: (value) {
                                        if (value!.isEmpty ||
                                            !value.contains('@')) {
                                          return 'Please enter a valid email address.';
                                        }
                                        return null;
                                      },
                                      onSaved: (value) {
                                        _email = value!;
                                      },
                                    ),
                                  ),
                                  Container(
                                    padding: EdgeInsets.symmetric(
                                        vertical: 10.h, horizontal: 10.h),
                                    decoration: BoxDecoration(
                                        border: Border(
                                            bottom: BorderSide(
                                                color: Colors.grey.shade200))),
                                    child: TextFormField(
                                      validator: (value) {
                                        if (value!.isEmpty ||
                                            value.length < 6) {
                                          return 'Password must be at least 7 characters';
                                        }
                                        return null;
                                      },
                                      obscureText: true,
                                      decoration: InputDecoration(
                                          hintText: "Password",
                                          hintStyle:
                                              TextStyle(color: Colors.grey),
                                          border: InputBorder.none),
                                      onSaved: (value) {
                                        _password = value!;
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(30.w, 0, 30.w, 0),
                      child: Container(
                        height: 40.h,
                        margin: EdgeInsets.symmetric(horizontal: 50.w),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50.r),
                        ),
                        child: ElevatedButton(
                          onPressed: _tryLogin,
                          style: ElevatedButton.styleFrom(
                              shadowColor: Colors.transparent,
                              elevation: 0,
                              primary: Color.fromRGBO(255, 61, 92, 1),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(50.r))),
                          child: Center(
                            child: Text(
                              "Login",
                              style: TextStyle(
                                  fontSize: 20.sp,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(30.w, 0, 30.w, 0),
                      child: Container(
                        height: 40.h,
                        margin: EdgeInsets.symmetric(horizontal: 50.w),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50.r),
                        ),
                        child: OutlinedButton(
                          onPressed: () {
                            FirebaseMessaging.instance
                                .subscribeToTopic('cylonebloodsquad');
                            Navigator.of(context).pushNamed('form');
                            // final provider = Provider.of<GoogleSignInProvider>(
                            //     context,
                            //     listen: false);
                            // provider.googleLogin();
                          },
                          style: OutlinedButton.styleFrom(
                              primary: Color.fromRGBO(255, 61, 92, 1),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(50.r),
                              ),
                              side: BorderSide(
                                color: Color.fromRGBO(255, 61, 92, 1),
                              )),
                          child: Row(
                            children: [
                              FaIcon(
                                FontAwesomeIcons.google,
                                color: Color.fromRGBO(255, 61, 92, 1),
                              ),
                              Padding(
                                padding: EdgeInsets.fromLTRB(10.w, 0, 0, 0),
                                child: Text(
                                  "Register",
                                  style: TextStyle(
                                      fontSize: 15.sp,
                                      color: Color.fromRGBO(255, 61, 92, 1),
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
