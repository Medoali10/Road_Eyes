import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:async';
import 'main.dart';

Color primary = Color(0xff4fa8a9);
Color primaryDark = Color(0xff214748);
Color accent = Color(0xffe37e7c);
Color accentLight = Color(0xfff7aeac);
double leftMargin = 30;

class Home extends StatefulWidget {
  @override
  _Home createState() => _Home();
}

class _Home extends State<Home> with TickerProviderStateMixin {
  AnimationController _controllerBody;
  Animation<double> _animationBody;

  AnimationController _controllerBulb;
  Animation<double> _animationBulb;

  @override
  void dispose() {
    _controllerBody.dispose();
    _controllerBulb.dispose();
    super.dispose();
  }

  int carsNum;
  int byNum;
  int persons;
  int motoNum;
  int trucks;
  dynamic speed = 0;
  int counter = 0;
  dynamic fspeed;

  final DocumentReference dataDoc = Firestore.instance.document("data/DATA");
  fetch() {
    dataDoc.get().then((datasnapshot) {
      if (datasnapshot.exists) {
        setState(() {
          counter++;
          speed += datasnapshot.data()["flow speed"];
          carsNum = datasnapshot.data()["cars"];
          byNum = datasnapshot.data()["bicycles"];
          persons = datasnapshot.data()["persons"];
          motoNum = datasnapshot.data()["motorbikes"];
          trucks = datasnapshot.data()["trucks"];
          fspeed = speed / counter;
        });
      }
    });
  }

  @override
  void initState() {
    _controllerBody = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 600),
    );
    _animationBody = Tween<double>(begin: 0, end: 1).animate(CurvedAnimation(
      parent: _controllerBody,
      curve: Curves.easeOut,
    ));

    _controllerBulb = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 1500),
    );
    _animationBulb = Tween<double>(begin: 0, end: 1).animate(CurvedAnimation(
      parent: _controllerBulb,
      curve: Curves.easeInOutQuint,
    ));
    super.initState();
    Timer.periodic(Duration(seconds: 3), (timer) {
      fetch();
    });
  }

  Widget build(BuildContext context) {
    _controllerBody.forward();
    _controllerBulb.forward();
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Builder(
        builder: (BuildContext context) {
          return Scaffold(
            appBar: AppBar(
              elevation: 0,
              backgroundColor: primary,
              leading: Container(
                margin: EdgeInsets.only(left: 30),
              ),
            ),
            body: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(
                    left: 30,
                    top: 30,
                  ),
                  child: Text(
                    'Road Eyes',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 35,
                        letterSpacing: 2,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                Expanded(
                  child: Stack(
                    children: <Widget>[
                      Container(
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(60),
                            )),
                        margin: EdgeInsets.only(top: 70),
                      ),
                      FadeTransition(
                        opacity: _animationBody,
                        child: SlideTransition(
                          position: Tween<Offset>(
                            begin: const Offset(0, 1),
                            end: Offset(0, 0),
                          ).animate(_animationBody),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Container(
                                padding: EdgeInsets.only(left: leftMargin),
                                alignment: Alignment.centerLeft,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text(
                                      'Number of cars'.toUpperCase(),
                                      style: TextStyle(
                                          fontSize: 16,
                                          color: primaryDark,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      "$carsNum".toUpperCase(),
                                      style: TextStyle(
                                          fontSize: 66,
                                          color: primaryDark,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.only(left: leftMargin),
                                alignment: Alignment.centerLeft,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text(
                                      'Flow speed'.toUpperCase(),
                                      style: TextStyle(
                                          fontSize: 16,
                                          color: accent,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      "$fspeed".toUpperCase(),
                                      style: TextStyle(
                                        fontSize: 36,
                                        color: accent,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.only(left: leftMargin),
                                alignment: Alignment.centerLeft,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text(
                                      'Number of persons'.toUpperCase(),
                                      style: TextStyle(
                                          fontSize: 16,
                                          color: accent,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      "$persons".toUpperCase(),
                                      style: TextStyle(
                                        fontSize: 36,
                                        color: accent,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.only(left: leftMargin),
                                alignment: Alignment.centerLeft,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text(
                                      'Number of bicycles'.toUpperCase(),
                                      style: TextStyle(
                                          fontSize: 16,
                                          color: accent,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      "$byNum".toUpperCase(),
                                      style: TextStyle(
                                        fontSize: 36,
                                        color: accent,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.only(left: leftMargin),
                                alignment: Alignment.centerLeft,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text(
                                      'Number of motorbikesn'.toUpperCase(),
                                      style: TextStyle(
                                          fontSize: 16,
                                          color: accent,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      "$motoNum".toUpperCase(),
                                      style: TextStyle(
                                        fontSize: 36,
                                        color: accent,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.only(left: leftMargin),
                                alignment: Alignment.centerLeft,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text(
                                      'Number of trucks'.toUpperCase(),
                                      style: TextStyle(
                                          fontSize: 16,
                                          color: accent,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      "$trucks".toUpperCase(),
                                      style: TextStyle(
                                        fontSize: 36,
                                        color: accent,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      FadeTransition(
                        opacity: _animationBulb,
                        child: SlideTransition(
                          position: Tween<Offset>(
                            begin: const Offset(0, 1),
                            end: Offset(0, 0),
                          ).animate(_animationBulb),
                          child: Align(
                            alignment: Alignment.topRight,
                            //THE BULB
                            child: Stack(
                              children: <Widget>[
                                Align(
                                  alignment: Alignment.topRight,
                                  child: Container(
                                      margin: EdgeInsets.only(top: 40),
                                      height: 80,
                                      width: 90,
                                      child: Container(
                                        decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius: BorderRadius.only(
                                                topLeft: Radius.circular(40))),
                                      )),
                                ),
                                Align(
                                  alignment: Alignment.topRight,
                                  child: Container(
                                    width: 200,
                                    child: ShaderMask(
                                      shaderCallback: (Rect bounds) {
                                        return LinearGradient(
                                          begin: Alignment.topLeft,
                                          end: Alignment(-0.4, -0.8),
                                          stops: [0.0, 0.5, 0.5, 1],
                                          colors: [
                                            accentLight,
                                            accentLight,
                                            accent,
                                            accent,
                                          ],
                                          tileMode: TileMode.repeated,
                                        ).createShader(bounds);
                                      },
                                      child: Icon(
                                        Icons.lightbulb_outline,
                                        size: 350,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                                Align(
                                  alignment: Alignment.topRight,
                                  child: Container(
                                    margin: EdgeInsets.only(top: 28),
                                    width: 130,
                                    height: 130,
                                    decoration: BoxDecoration(
                                        color: Colors.white.withOpacity(0.9),
                                        borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(105),
                                          topRight: Radius.elliptical(5, 0),
                                        )),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
            backgroundColor: primary,
          );
        },
      ),
    );
  }
}
