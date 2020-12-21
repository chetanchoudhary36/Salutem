import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_scan_bluetooth_example/Landing/gldash.dart';
import 'package:flutter_scan_bluetooth_example/nearby_interface.dart';

class Glog extends StatefulWidget {
  const Glog({Key key}) : super(key: key);

  @override
  _Glog createState() => _Glog();
}

class _Glog extends State<Glog> {
  final scaffoldKey = new GlobalKey<ScaffoldState>();
  final formKey = new GlobalKey<FormState>();
  //var _textController = new TextEditingController();        //mayuresh
 bool showSpinner = false;
  final _auth = FirebaseAuth.instance;
  String email;
  String password;


  String _mac;
  String _password;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  //  WidgetsFlutterBinding.ensureInitialized();
  // Firebase.initializeApp();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  void _submit() {
    final form = formKey.currentState;

    if (form.validate()) {
      form.save();

      performLogin();

      Navigator.pushNamed(context, '/tab-bar');
    }
  }

  void performLogin() {
    final snackbar = new SnackBar(
      content: new Text("Logged In."),
    );
    scaffoldKey.currentState.showSnackBar(snackbar);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: scaffoldKey,
        //appBar: new AppBar(
        // title: new Text("Form Page"),
        // ),
        body: Container(
            padding: const EdgeInsets.only(top: 50.0),
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("lib/assets/twoleaves.png"),
                    fit: BoxFit.cover)),
            child: ListView(children: <Widget>[
              new Padding(
                padding: const EdgeInsets.all(20.0),
                child: new Form(
                  key: formKey,
                  child: new Column(
                    children: <Widget>[
                      new Text(
                        'Welcome to GLan Health Login !',
                        style: TextStyle(
                          fontFamily: 'Avenir',
                          fontSize: 30.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.green,
                        ),
                      ),


                TextField(
                  keyboardType: TextInputType.emailAddress,
                  textAlign: TextAlign.center,
                  onChanged: (value) {
                    email = value;
                  },
                  decoration: new InputDecoration(
                      hintText: 'Enter your email'),
                ),
                SizedBox(
                  height: 8.0,
                ),
                TextField(
                  obscureText: true,
                  textAlign: TextAlign.center,
                  onChanged: (value) {
                    password = value;
                  },
                  decoration: new InputDecoration(
                      hintText: 'Enter your password'),
                ),
                SizedBox(
                  height: 24.0,
                ),


                      // new TextFormField(
                      //   decoration: new InputDecoration(labelText: "MAC"),
                      //   //validator: (val) =>
                      //   // !val.contains('@') ? 'Invalid Email' : null,
                      //   // onSaved: (val) => _mac = val,
                      //   // controller: _textController,            //mayuresh
                      // ),
                      // new TextFormField(
                      //   decoration: new InputDecoration(labelText: "Password"),
                      //   validator: (val) =>
                      //       val.length < 6 ? 'Password too short' : null,
                      //   onSaved: (val) => _password = val,
                      //   obscureText: true,
                      // ),
                      new Padding(
                        padding: const EdgeInsets.only(top: 20.0),
                      ),
                      FloatingActionButton.extended(
                        label: Text('Login',
                            style: TextStyle(
                              //color: Colors.blueGrey[100],
                              fontFamily: 'Avenir',
                              fontWeight: FontWeight.bold,
                              fontSize: 15.0,
                            )),
                        backgroundColor:
                            Color.alphaBlend(Colors.green, Colors.green),
                        //onPressed: _submit,

                            onPressed: () async {
                               Navigator.push(context,
                     new MaterialPageRoute(builder: (context) => new Gldash()));
                    setState(() {
                      //showSpinner = true;
                    });
                    
                    
                  },
                      ),
                      /* new RaisedButton(
                        child: new Text(
                          "Login",
                          style: new TextStyle(color: Colors.white),
                        ),
                        color: Colors.green,
                        onPressed: _submit,
                      )*/
                    ],
                  ),
                ),
              ),
            ])));
  }
}
