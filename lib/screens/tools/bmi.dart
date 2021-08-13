import 'package:flutter/material.dart';
import 'package:bloodsquad/widgets/pagewidgets.dart';
import 'package:bloodsquad/widgets/imagewidget.dart';

class Bmi extends StatefulWidget {
  @override
  _BmiState createState() => _BmiState();
}

class _BmiState extends State<Bmi> {
  final TextEditingController _heightController = TextEditingController();
  final TextEditingController _weightController = TextEditingController();

  double? _result;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            width: double.infinity,
            decoration: backgroundImage(),
            child: Column(children: [
              Stack(
                children: [
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
                  MainTitle('BMI Calculator'),
                ],
              ),
              SizedBox(
                height: 60,
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10.0),
                child: Column(
                  children: <Widget>[
                    TextField(
                      controller: _heightController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        labelText: 'height in cm',
                        icon: Icon(Icons.trending_up),
                      ),
                    ),
                    SizedBox(height: 20),
                    TextField(
                      controller: _weightController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        labelText: 'weight in kg',
                        icon: Icon(Icons.line_weight),
                      ),
                    ),
                    SizedBox(height: 15),
                    RaisedButton(
                      color: Colors.pinkAccent,
                      child: Text(
                        "Calculate",
                        style: TextStyle(color: Colors.white),
                      ),
                      onPressed: calculateBMI,
                    ),
                    SizedBox(height: 15),
                    Text(
                      _result == null
                          ? "Enter Value"
                          : "${_result!.toStringAsFixed(2)}",
                      style: TextStyle(
                        color: Colors.redAccent,
                        fontSize: 19.4,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            ])));
    // return Scaffold(
    //   appBar: AppBar(
    //       title: Text('BMI Calculator'),
    //       centerTitle: true,
    //       backgroundColor: Color.fromRGBO(255, 83, 122, 1)),
    //   body: Container(
    //     padding: EdgeInsets.symmetric(horizontal: 10.0),
    //     child: Column(
    //       children: <Widget>[
    //         TextField(
    //           controller: _heightController,
    //           keyboardType: TextInputType.number,
    //           decoration: InputDecoration(
    //             labelText: 'height in cm',
    //             icon: Icon(Icons.trending_up),
    //           ),
    //         ),
    //         SizedBox(height: 20),
    //         TextField(
    //           controller: _weightController,
    //           keyboardType: TextInputType.number,
    //           decoration: InputDecoration(
    //             labelText: 'weight in kg',
    //             icon: Icon(Icons.line_weight),
    //           ),
    //         ),
    //         SizedBox(height: 15),
    //         RaisedButton(
    //           color: Colors.pinkAccent,
    //           child: Text(
    //             "Calculate",
    //             style: TextStyle(color: Colors.white),
    //           ),
    //           onPressed: calculateBMI,
    //         ),
    //         SizedBox(height: 15),
    //         Text(
    //           _result == null
    //               ? "Enter Value"
    //               : "${_result!.toStringAsFixed(2)}",
    //           style: TextStyle(
    //             color: Colors.redAccent,
    //             fontSize: 19.4,
    //             fontWeight: FontWeight.w500,
    //           ),
    //         ),
    //       ],
    //     ),
    //   ),
    // );
  }

  void calculateBMI() {
    double height = double.parse(_heightController.text) / 100;
    double weight = double.parse(_weightController.text);

    double heightSquare = height * height;
    double result = weight / heightSquare;

    _result = result;

    setState(() {});
  }
}
