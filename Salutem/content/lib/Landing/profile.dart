import 'package:flutter/material.dart';
import 'package:flutter_scan_bluetooth_example/Landing/glog.dart';
import 'package:flutter_scan_bluetooth_example/Landing/udash.dart';

class Profile extends StatefulWidget {
  Profile(this.colorVal);
  int colorVal;

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile>  {
 // const Profile({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Center(
          child: Container(
              height: 820,
              width: 400,
              child: Padding(
                  padding: const EdgeInsets.all(40),
                  child: ListView(
                   // mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Image(
                          height: 350,
                          width: 220,
                          image: AssetImage("lib/assets/GlanHealth-logo.png")),
                      RaisedGradientButton(
                          child: Text(
                            'glanHealth Admin',
                            style: TextStyle(
                              color: Colors.white,
                              fontFamily: 'Avenir',
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          gradient: LinearGradient(
                            colors: <Color>[Colors.pink, Colors.blue],
                          ),
                          onPressed: () {
                            //Navigator.pushNamed(context, '/user-login');
                             Navigator.push(context,
                     new MaterialPageRoute(builder: (context) => new Glog()));
                          }),
                      SizedBox(height: 20),
                      RaisedGradientButton(
                          child: Text(
                            'Continue As User',
                            style: TextStyle(
                              color: Colors.white,
                              fontFamily: 'Avenir',
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          gradient: LinearGradient(
                            colors: <Color>[Colors.pink, Colors.blue],
                          ),
                          onPressed: () {
                             Navigator.push(context,
                     new MaterialPageRoute(builder: (context) => new Udash()));
                          }),
                    ],
                  ))),
        ));
  }
}

//......................................................................
class RaisedGradientButton extends StatelessWidget {
  final Widget child;
  final Gradient gradient;
  final double width;
  final double height;
  final Function onPressed;

  const RaisedGradientButton({
    Key key,
    @required this.child,
    this.gradient,
    this.width = double.infinity,
    this.height = 50.0,
    this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: 50.0,
      decoration: BoxDecoration(gradient: gradient, boxShadow: [
        BoxShadow(
          color: Colors.grey[500],
          offset: Offset(0.0, 1.5),
          blurRadius: 1.5,
        ),
      ]),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
            onTap: onPressed,
            child: Center(
              child: child,
            )),
      ),
    );
  }
}
