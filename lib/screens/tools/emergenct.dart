import 'package:flutter/material.dart';
import 'package:bloodsquad/widgets/pagewidgets.dart';
import 'package:bloodsquad/widgets/imagewidget.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';

class Emergency extends StatefulWidget {
  const Emergency({Key? key}) : super(key: key);

  @override
  _EmergencyState createState() => _EmergencyState();
}

class _EmergencyState extends State<Emergency> {
  TextEditingController _numberCtrl = new TextEditingController();
  @override
  void initState() {
    super.initState();
    _numberCtrl.text = "1990";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
            MainTitle('Emergency'),
            Card(
              child: Column(children: <Widget>[
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: TextField(
                    controller: _numberCtrl,
                    decoration: InputDecoration(labelText: "SuwaSariya"),
                    keyboardType: TextInputType.number,
                  ),
                ),
                RaisedButton(
                  child: Text(" Call"),
                  onPressed: () async {
                    FlutterPhoneDirectCaller.callNumber(_numberCtrl.text);
                  },
                ),
              ]),
            )
          ])),
    );
  }
}

// return Scaffold(
//       body:Container(
//             width: double.infinity,
//             decoration: backgroundImage(),
//             child: Column(children: [
//               MainTitle('BMI Calculator'),
//             ]
//             )
//       ),
      
//     );