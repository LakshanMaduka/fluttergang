import 'package:bloodsquad/screens/tools.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';
import 'profile.dart';
import 'Map.dart';
import 'news.dart';
import 'dashboard.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool istp = true;

  var colors;
  void isTap() {}

  int currentTab = 0;
  final List<Widget> screens = [
    Profile(),
    Map(),
    News(),
    Dashboard(),
    ToolsPage()
  ];

  final PageStorageBucket bucket = PageStorageBucket();
  Widget currentScreen = Dashboard();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: PageStorage(
          child: currentScreen,
          bucket: bucket,
        ),
      ),
      floatingActionButton: FloatingActionButton(
        splashColor: Colors.white,
        backgroundColor: colors,
        foregroundColor: Colors.pinkAccent,
        child: Icon(
          Icons.dashboard,
          color: Colors.teal[900],
        ),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(100.r),
            side: BorderSide(
                color: Color.fromRGBO(255, 83, 122, 1), width: 4.0.w)),
        elevation: 2.0,
        onPressed: () {
          setState(() {
            if (istp) {
              colors = Color.fromRGBO(255, 83, 122, 1);
              currentScreen = ToolsPage();
              currentTab = 4;
              // Navigator.of(context).push(MaterialPageRoute(builder: (_) {
              //   return ToolsPage();
              // }));
              istp = false;
            } else {
              currentScreen = Dashboard();
              currentTab = 0;

              colors = Colors.white;
              istp = true;
            }
          });
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        shape: CircularNotchedRectangle(),
        notchMargin: 10,
        child: Container(
          height: 60.h,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  MaterialButton(
                    minWidth: 80.w,
                    onPressed: () {
                      setState(() {
                        currentScreen = Dashboard();
                        currentTab = 0;
                        colors = Colors.white;
                        istp = true;
                      });
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.home,
                          color: currentTab == 0
                              ? Color.fromRGBO(255, 83, 122, 1)
                              : Colors.grey,
                          size: 30.sp,
                        ),
                      ],
                    ),
                  ),
                  MaterialButton(
                    minWidth: 80.w,
                    onPressed: () {
                      setState(() {
                        currentScreen = Profile();
                        currentTab = 1;
                        colors = Colors.white;
                        istp = true;
                      });
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.person,
                          color: currentTab == 1
                              ? Color.fromRGBO(255, 83, 122, 1)
                              : Colors.grey,
                          size: 30.sp,
                        ),
                      ],
                    ),
                  )
                ],
              ),
              //Right Tab Bar Icons
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  MaterialButton(
                    minWidth: 80.w,
                    onPressed: () {
                      setState(() {
                        currentScreen = Map();
                        currentTab = 2;
                        colors = Colors.white;
                        istp = true;
                      });
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.location_on,
                          color: currentTab == 2
                              ? Color.fromRGBO(255, 83, 122, 1)
                              : Colors.grey,
                          size: 30.sp,
                        ),
                      ],
                    ),
                  ),
                  MaterialButton(
                    minWidth: 80.w,
                    onPressed: () {
                      setState(() {
                        currentScreen = News();
                        currentTab = 3;
                        colors = Colors.white;
                        istp = true;
                      });
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.feed_outlined,
                          color: currentTab == 3
                              ? Color.fromRGBO(255, 83, 122, 1)
                              : Colors.grey,
                          size: 30.sp,
                        ),
                      ],
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
