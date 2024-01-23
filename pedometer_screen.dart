import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pedometer/pedometer.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

void main() => runApp(PedometerScreens());

class PedometerScreens extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<PedometerScreens> {
  String _km = "";
  String _stepCountValue = "";
  String _calories = "";
  String stepCountValue = "";
  StreamSubscription<int>? _subscription;

  late double _numerox;
  late double _kmx;
  late double _burnedx;
  late double _convert;
  get percent => null;

  @override
  void initState() {
    super.initState();
    setUpPedometer();
  }

  void setUpPedometer() {
    Pedometer pedometer = Pedometer();
    _subscription = Pedometer.stepCountStream.cast<int>().listen(
          _onData,
          onError: _onError,
          onDone: _onDone,
          cancelOnError: true,
        );
  }

  void _onDone() {}

  void _onError(error) {
    print("Flutter Pedometer Error: $error");
  }

  void _onData(int stepCountValue) async {
    print(stepCountValue);
    setState(() {
      _stepCountValue = "$stepCountValue";
      print(_stepCountValue);
    });

    var distance = stepCountValue;
    double y = (distance + .0);

    setState(() {
      _numerox = y;
    });

    num long3 = (_numerox);
    long3 = num.parse(y.toStringAsFixed(3));
    var long4 = (long3 / 10000);
    getDistanceRun(_numerox);

    setState(() {
      _convert = long4;
      print(_convert);
    });
  }

  void getDistanceRun(double _numerox) {
    num distance = ((_numerox * 78) / 100000);
    distance = num.parse(distance.toStringAsFixed(2));
    setState(() {
      _km = "$distance";
      print(_km);
    });
    setState(() {
      _kmx = distance * 30;
    });
  }

  void getBurnedRun() {
    setState(() {
      _calories = "$_km";
      print(_calories);
    });
  }

  //void _onError(error) {
  //print("Flutter Pedometer Error: $error");
  //}

  //void _onDone() {
  // print("Pedometer stream done");
  //}

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: const Text('appStep Count'),
        ),
        body: Container(
          color: Color(0xFF7615D6),
          child: ListView(
            padding: EdgeInsets.only(top: 5.0, left: 5.0, right: 5.0),
            children: <Widget>[
              Container(
                padding: EdgeInsets.only(top: 10.0),
                width: 200,
                height: 200,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                    colors: [Color(0xFFAA9F5F2), Color(0xFF6175D6)],
                  ),
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(27.0),
                    bottomRight: Radius.circular(27.0),
                    topLeft: Radius.circular(27.0),
                    topRight: Radius.circular(27.0),
                  ),
                ),
                child: new CircularPercentIndicator(
                  radius: 150,
                  lineWidth: 13,
                  animation: true,
                  center: new Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.only(left: 20),
                        child: Icon(
                          FontAwesomeIcons.walking,
                          size: 30,
                          color: Colors.white,
                        ),
                      ),
                      Container(
                        child: Text("$_stepCountValue",
                            style: new TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 20,
                              color: Colors.white54,
                            )),
                      ),
                    ],
                  ),
                  percent: _convert,
                  footer: new Text(
                    "Steps $_stepCountValue",
                    style: new TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 12.0,
                      color: Colors.black,
                    ),
                  ),
                  circularStrokeCap: CircularStrokeCap.round,
                  progressColor: Color(0xFF7165D6),
                ),
              ),
              Divider(
                height: 10,
              ),
              Container(
                padding: EdgeInsets.only(left: 25.0, top: 10.0, bottom: 10.0),
                color: Colors.transparent,
                child: Row(
                  children: [
                    Container(),
                  ],
                ),
              ),
              // Additional widgets can be added here
            ],
          ),
        ),
      ),
    );
  }
}
