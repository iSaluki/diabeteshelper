import 'dart:async';
import 'package:diabeteshelper/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class SplashScreen extends StatefulWidget {
  final Color backgroundColor = Colors.white;
  final TextStyle styleTextUnderTheLoader = TextStyle(
      fontSize: 18.0, fontWeight: FontWeight.bold, color: Colors.black);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  String _versionName = 'V1.0';
  final splashDelay = 5;

  @override
  void initState() {
    super.initState();

    _loadWidget();
  }

  _loadWidget() async {
    var _duration = Duration(seconds: splashDelay);
    return Timer(_duration, navigationPage);
  }

  void navigationPage() {
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context) => start()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            height: MediaQuery
                .of(context)
                .size
                .height,
            width: MediaQuery
                .of(context)
                .size
                .width,
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    colors: [
                      const Color(0xff063000),
                      const Color(0xffffffff)
                    ],
                    begin: FractionalOffset.topRight,
                    end: FractionalOffset.bottomLeft)),
          ),
          InkWell(

            child: Stack(

              fit: StackFit.expand,
              children: <Widget>[
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Expanded(
                      flex: 7,
                      child: Container(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[

                              RichText(
                                text: TextSpan(
                                  style: TextStyle(
                                      fontSize: 30
                                  ),
                                  children: <TextSpan>[
                                    TextSpan(text: 'Diabetic', style: TextStyle(fontWeight: FontWeight.w600
                                        , color: Colors.black54)),
                                    TextSpan(text: ' Helper ', style: TextStyle(fontWeight: FontWeight.w600
                                        , color: Colors.green)),
                                  ],
                                ),
                              ),
                            ],
                          )),
                    ),
                    Expanded(
                      child: Column(
                        children: <Widget>[
                          SpinKitCubeGrid(
                            color: Colors.green[900],
                          ),
                          Container(
                            height: 10,
                          ),
                          Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: <Widget>[
                                Spacer(),
                                Text("V1.1"),
                                Spacer(
                                  flex: 4,
                                ),
                                Text('Saluki Corporation'),
                                Spacer(),
                              ])
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      )
    );
  }
}