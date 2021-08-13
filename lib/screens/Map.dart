import 'package:bloodsquad/mainpage.dart';
import 'package:bloodsquad/widgets/pagewidgets.dart';
import 'package:flutter/material.dart';
import 'package:bloodsquad/widgets/imagewidget.dart';

class Map extends StatefulWidget {
  const Map({Key? key}) : super(key: key);

  @override
  _MapState createState() => _MapState();
}

class _MapState extends State<Map> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      width: double.infinity,
      decoration: backgroundImage(),
      child: Column(
        children: [
          MainTitle('Find BloodBank'),
        ],
      ),
    ));
  }
}
