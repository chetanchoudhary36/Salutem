import 'package:flutter/material.dart';
import 'package:flutter_scan_bluetooth_example/Bluetooth/ble.dart';
import 'package:flutter_scan_bluetooth_example/On_Boarding/onboarding.dart';

class Start_up extends StatelessWidget {
  const Start_up({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          // padding: const EdgeInsets.only(top: 50.0, left: 30.0),
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("lib/assets/bkg.png"),
              fit: BoxFit.cover,
            ),
          ),
          child: Column(children: <Widget>[
            new Padding(
              padding: const EdgeInsets.all(250.0),
            ),
            FloatingActionButton.extended(
                label: Text('Login',
                    style: TextStyle(
                      //color: Colors.blueGrey[100],
                      fontFamily: 'Avenir',
                      fontWeight: FontWeight.bold,
                      fontSize: 15.0,
                    )),
                backgroundColor: Color.alphaBlend(Colors.green, Colors.green),
                onPressed: () {
                  Navigator.pushNamed(context, '/login');
                }),
            FlatButton(
                onPressed: () {
                  Navigator.push(context,
                      new MaterialPageRoute(builder: (context) => new MyApp()));
                },
                child: Text("Register"))
          ])),
    );
  }
}
