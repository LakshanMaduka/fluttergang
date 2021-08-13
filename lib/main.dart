//@dart=2.9

import 'package:bloodsquad/form/form.dart';
import 'package:bloodsquad/form/form_screen.dart';
import 'package:bloodsquad/google_sign_in.dart';

import 'package:bloodsquad/login.dart';
import 'package:bloodsquad/onboard/onboard.dart';

import 'package:bloodsquad/screens/home.dart';
import 'package:bloodsquad/screens/news.dart';
import 'package:bloodsquad/screens/tools/bmi.dart';
import 'package:bloodsquad/screens/tools/emergenct.dart';
import 'package:bloodsquad/screens/tools/friends.dart';
import 'package:bloodsquad/screens/tools/history.dart';
import 'package:bloodsquad/services/local_notification_service.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

import 'package:flutter/material.dart';
import 'package:bloodsquad/widgets/loginform.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/services.dart';

Future<void> backgroundHandler(RemoteMessage message) async {
  print(message.data.toString());
  print(message.notification.title);
}

int isviewed;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  FirebaseMessaging.onBackgroundMessage(backgroundHandler);
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
  ));
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  isviewed = prefs.getInt('onBoard');

  runApp(MyHomePage());
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    super.initState();

    LocalNotificationService.initialize(context);

    FirebaseMessaging.instance.getInitialMessage().then((message) {
      if (message != null) {
        final routeFromMessage = message.data["route"];

        Navigator.of(context).pushNamed(routeFromMessage);
      }
    });

    FirebaseMessaging.onMessage.listen((message) {
      if (message.notification != null) {
        print(message.notification.body);
        print(message.notification.title);
      }

      LocalNotificationService.display(message);
    });

    FirebaseMessaging.onMessageOpenedApp.listen((message) {
      final routeFromMessage = message.data["route"];

      Navigator.of(context).pushNamed(routeFromMessage);
    });
    FirebaseMessaging.instance.subscribeToTopic('cylonebloodsquad');
  }

  @override
  Widget build(BuildContext context) => ChangeNotifierProvider(
        create: (context) => GoogleSignInProvider(),
        child: ScreenUtilInit(
          designSize: Size(360, 640),
          builder: () => MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Blood Squad',
            theme: ThemeData(
              primarySwatch: Colors.pink,
              fontFamily: 'Montserrat',
            ),
            home: Scaffold(
              body: StreamBuilder(
                  stream: FirebaseAuth.instance.authStateChanges(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasData) {
                      return Home();
                    } else if (snapshot.hasError) {
                      return Center(
                        child: Text('Something Went Wrong'),
                      );
                    } else {
                      return isviewed != 0 ? OnBoard() : LoginPage();
                    }
                  }),
            ),
            routes: {
              'news': (_) => News(),
              'home': (_) => Home(),
              'form': (_) => FormScreen(),
              'history': (_) => History(),
              'bmi': (_) => Bmi(),
              'emergency': (_) => Emergency(),
              'friends': (_) => Friends(),
            },
          ),
        ),
      );
}
