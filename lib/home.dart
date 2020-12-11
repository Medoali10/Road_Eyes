import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:async';

class Home extends StatefulWidget {

  @override
  _Home createState() => _Home();
}

class _Home extends State<Home> {
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
dataDoc.get().then((datasnapshot){
       if(datasnapshot.exists){
         setState(() {
          counter++;
           speed += datasnapshot.data()["flow speed"];
            carsNum = datasnapshot.data()["cars"];
            byNum = datasnapshot.data()["bicycles"];
            persons = datasnapshot.data()["persons"];
            motoNum = datasnapshot.data()["motorbikes"];
            trucks = datasnapshot.data()["trucks"];
            fspeed = speed / counter;
         }); }
     });}

  @override
  void initState() {
  super.initState();
  Timer.periodic(Duration(seconds: 3), (timer) {
  fetch();
});
}
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Center(child:Text("Road Eyes",
        style: TextStyle(
          color: Colors.orange
        ),),),
      ),
      drawer: Drawer(
  child: ListView(
    padding: EdgeInsets.fromLTRB(0,25,0,0),
    children: <Widget>[
      ListTile(
        leading: CircleAvatar(backgroundImage: AssetImage("assets/123.png",),
        foregroundColor: Colors.black,),
          title: Text("Road Eyes"),
      ),
      ListTile(
        title: Text('Data'),
        onTap: () {
          Navigator.pushReplacementNamed(context, 'home');
        },
      ),
    ],
  ),
),
      body:Center(
         child: Column(mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
            Text("Number of cars: $carsNum ",
            style: TextStyle(
              fontSize: 20
            ),),
            Text("Flow speed: $fspeed ",
            style: TextStyle(
              fontSize: 20
            ),),
            Text("Number of persons: $persons ",
            style: TextStyle(
              fontSize: 20
            ),),
            Text("Number of bicycles: $byNum ",
            style: TextStyle(
              fontSize: 20
            ),),
            Text("Number of motorbikes: $motoNum ",
            style: TextStyle(
              fontSize: 20
            ),),
            Text("Number of trucks: $trucks ",
            style: TextStyle(
              fontSize: 20
            ),),
          ],)
      )
    );
  }
  }