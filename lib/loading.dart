import 'package:flutter/material.dart';

class Loading extends StatefulWidget {

  @override
  _Loading createState() => _Loading();
}

class _Loading extends State<Loading> {

void nextRoute(){
Future.delayed(Duration(seconds: 3),() {
Navigator.pushReplacementNamed(context, 'home');
});
}

  @override
  void initState(){
    super.initState();
  nextRoute();
  }
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.black,
     body:Center(child: Row(mainAxisAlignment: MainAxisAlignment.center,
       children: <Widget>[Text("R",
        style: TextStyle(fontSize: 50,
        color: Colors.orange)
        ,)
        , Image(image: AssetImage('assets/123.png'), width: 40, height: 40,)
        ,Text("AD EYES",
        style: TextStyle(fontSize: 50,
        color: Colors.orange))],
)
     ),
    );
  }
  }
