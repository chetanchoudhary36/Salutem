import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_scan_bluetooth_example/Bluetooth/ble.dart';
import 'package:flutter_scan_bluetooth_example/Self-assess/selfassess_content.dart';
import 'package:flutter_scan_bluetooth_example/Testresult.dart';
import 'package:flutter_scan_bluetooth_example/nearby_interface.dart';
import 'package:flutter_scan_bluetooth_example/Self-assess/result.dart';
import 'package:flutter_scan_bluetooth_example/Self-assess/result.dart';
import 'package:localstorage/localstorage.dart';
//import 'package:font_awesome_flutter/font_awesome_flutter.dart';
//import 'package:flutter_blue/flutter_blue.dart';

class Home extends StatefulWidget {
  Home(this.colorVal);
 // e multiple values add here
//Home(this.resultScore, {Key key}): super(key: key);//add also..example this.abc,this...

int colorVal;


//final int resultScore;//if you hav

  @override
  _HomeState createState() => _HomeState();
}

int name=2;
int disp;
class _HomeState extends State<Home> {
 // String get resultScore => null;
final LocalStorage storage = new LocalStorage('localstorage_app');


  //get _tabController => null;
void getitemFromLocalStorage() {
   name = storage.getItem('name');
   print("--------------");
  // print(name);
   print("--------------");
}

void getitemFromStorage() {
  if(name==null){
disp=2;
  }else{
    disp=name;
  }
}

@override
  void initState() {
    super.initState();
  //_onAlertButtonPressed(context);
   // deleteOldContacts(14);
  //  addContactsToList();
  //  getPermissions();
  getitemFromLocalStorage();
    Timer.run(() => getitemFromLocalStorage());
    getitemFromStorage();
    Timer.run(() => getitemFromStorage());

  // Timer.run(Duration(seconds: 18), (Timer t) => discovery());
 // Timer.run(() => discovery());
  }


  @override
  Widget build(BuildContext context) {
   
    return Scaffold(
        body: ListView(scrollDirection: Axis.vertical, children: <Widget>[
      Padding(
        padding: const EdgeInsets.all(16.0),
        child: GestureDetector(
          // onTap: () {
          //   Navigator.pushNamed(context, '/landing');
          // },
          child: new FittedBox(
            child: Material(
                color: Colors.white,
                elevation: 14.0,
                borderRadius: BorderRadius.circular(24.0),
                shadowColor: Color(0x802196F3),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Container(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 16.0),
                        child: myDetailsContainer1(),
                      ),
                    ),
                    Container(
                      width: 250,
                      height: 180,
                      child: ClipRRect(
                        borderRadius: new BorderRadius.circular(24.0),
                        child: Image(
                          fit: BoxFit.contain,
                          alignment: Alignment.topRight,
                          image: AssetImage("lib/assets/flower.jpg"),
                        ),
                      ),
                    ),
                  ],
                )),
          ),
        ),
      ),
      Padding(
        padding: const EdgeInsets.all(16.0),
        child: GestureDetector(
           onTap: () {
            // Navigator.pushNamed(context, SelfAssessContent());
            // Navigator.push(context,
            //   new MaterialPageRoute(builder: (context) => new Testresult()));
               Navigator.push(context,
                new MaterialPageRoute(builder: (context) => new SelfAssessContent(0x87938f)));
           },
          child: new FittedBox(
            child: Material(
                color: Colors.white,
                elevation: 14.0,
                borderRadius: BorderRadius.circular(24.0),
                shadowColor: Color(0x802196F3),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Container(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 16.0),
                        child: myDetailsContainer2(),
                      ),
                    ),
                    Container(
                      width: 250,
                      height: 180,
                      child: ClipRRect(
                        borderRadius: new BorderRadius.circular(24.0),
                        child: Image(
                          fit: BoxFit.contain,
                          alignment: Alignment.topRight,
                          image: AssetImage("lib/assets/flower.jpg"),
                        ),
                      ),
                    ),
                  ],
                )),
          ),
        ),
      ),
      Padding(
        padding: const EdgeInsets.all(16.0),
        child: GestureDetector(
          onTap: () {
            Navigator.push(context,
                new MaterialPageRoute(builder: (context) => new NearbyInterface()));
          },
          child: new FittedBox(
            child: Material(
                color: Colors.white,
                elevation: 14.0,
                borderRadius: BorderRadius.circular(24.0),
                shadowColor: Color(0x802196F3),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Container(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 16.0),
                        child: myDetailsContainer3(),
                      ),
                    ),
                    Container(
                      width: 250,
                      height: 180,
                      child: ClipRRect(
                        borderRadius: new BorderRadius.circular(24.0),
                        child: Image(
                          fit: BoxFit.contain,
                          alignment: Alignment.topRight,
                          image: AssetImage("lib/assets/tenor.gif"),
                        ),
                      ),
                    ),
                  ],
                )),
          ),
        ),
      ),
    ]));
  }

  Widget myDetailsContainer1() {
  //  String resultScore;
        return Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: Container(
                  child: Text("Vulnerability",
                      style: TextStyle(
                        color: Color.alphaBlend(Colors.green, Colors.green),
                        fontFamily: 'Avenir',
                        fontWeight: FontWeight.bold,
                        fontSize: 18.0,
                      ))),
            ),
            Container(
                child: Text(disp.toString(),
                style: TextStyle(
                  color: Colors.black,
                  fontFamily: 'Avenir',
                  //fontWeight: FontWeight.bold,
                  fontSize: 12.0,
                ))),
      ],
    );
  }

  Widget myDetailsContainer2() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: Container(
              child: Text("Self-Assess!",
                  style: TextStyle(
                    color: Color.alphaBlend(Colors.green, Colors.green),
                    fontFamily: 'Avenir',
                    fontWeight: FontWeight.bold,
                    fontSize: 18.0,
                  ))),
        ),
        Container(
            child: Text("Click To Start Self-Assess",
                style: TextStyle(
                  color: Colors.black,
                  fontFamily: 'Avenir',
                  //fontWeight: FontWeight.bold,
                  fontSize: 12.0,
                ))),
      ],
    );
  }

  Widget myDetailsContainer3() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: Container(
              child: Text("Contact Tracing",
                  style: TextStyle(
                    color: Color.alphaBlend(Colors.green, Colors.green),
                    fontFamily: 'Avenir',
                    fontWeight: FontWeight.bold,
                    fontSize: 18.0,
                  ))),
        ),
        Container(
            child: Text("Click To Start Tracing",
                style: TextStyle(
                  color: Colors.black,
                  fontFamily: 'Avenir',
                  //fontWeight: FontWeight.bold,
                  fontSize: 12.0,
                ))),
      ],
    );
  }
}
