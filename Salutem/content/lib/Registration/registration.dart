import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:flutter_scan_bluetooth_example/Landing/tab_bar.dart';
import 'package:flutter_scan_bluetooth_example/Login/login.dart';
import 'package:flutter_scan_bluetooth_example/nearby_interface.dart';

class Registration extends StatefulWidget {
  const Registration({Key key}) : super(key: key);

  @override
  _Registration createState() => _Registration();
}

class _Registration extends State<Registration> {
  final scaffoldKey = new GlobalKey<ScaffoldState>();
  final formKey = new GlobalKey<FormState>();

  final _auth = FirebaseAuth.instance;
  Firestore _firestore = Firestore.instance;
  bool showSpinner = false;
  String email;
  String password;
  String userName;

  String _mac;
  String _password;
  String _passwordverify;
  String _age;
  String _sex = "Choose Gender";
  var _sexvalue = ['Choose Gender', 'Male', 'Female', 'Other'];
  int _selectedGender = 0;

  List<DropdownMenuItem<int>> genderList = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
   // WidgetsFlutterBinding.ensureInitialized();
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

      Navigator.pushNamed(context, '/landing');
    }
  }

  void performLogin() {
    final snackbar = new SnackBar(
      content: new Text("Form Submitted :)"),
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
            child: Column(children: <Widget>[
              new Padding(
                padding: const EdgeInsets.all(20.0),
                child: new Form(
                  key: formKey,
                  child: new Column(
                    children: <Widget>[
                      new Text(
                        'Sign-Up On Salutem !',
                        style: TextStyle(
                          fontFamily: 'Avenir',
                          fontSize: 30.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.green,
                        ),
                      ),

                      // new TextFormField(
                      //   decoration:
                      //       new InputDecoration(labelText: "Email address"),
                      //   // validator: (val) =>
                      //   //     val.length < 1 ? 'Invalid Address' : null,
                      //   // onSaved: (val) => _mac = val,
                      // ),

                      TextField(
                  textAlign: TextAlign.center,
                  onChanged: (value) {
                    userName = value;
                  },
                  decoration:
                     new InputDecoration(hintText: 'Username'),
                ),
                SizedBox(
                  height: 8.0,
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
                      // new TextFormField(
                      //   decoration: new InputDecoration(labelText: "Password"),
                      //   validator: (val) =>
                      //       val.length < 6 ? 'Password too short' : null,
                      //   onSaved: (val) => _password = val,
                      //   obscureText: true,
                      // ),
                      // new TextFormField(
                      //   decoration:
                      //       new InputDecoration(labelText: "PasswordVerify"),
                      //   validator: (val) => val.allMatches(_password) != null
                      //       ? 'Password does not match'
                      //       : null,
                      //   onSaved: (val) => _passwordverify = val,
                      //   obscureText: true,
                      // ),
                      new TextFormField(
                        decoration: new InputDecoration(labelText: "Age"),
                        // validator: (val) =>
                        //     val.> 0 ?  null : 'Age Invalid',
                        onSaved: (val) => _age = val,
                        //obscureText: true,
                      ),
                      // new Text(
                      //   "data",
                      //   textAlign: TextAlign.left,
                      // ),
                      new DropdownButton<String>(
                        items: _sexvalue.map((String dropItems) {
                          return DropdownMenuItem<String>(
                            value: dropItems,
                            child: Text(dropItems),
                          );
                        }).toList(),
                        onChanged: (String newSex) {
                          setState(() {
                            this._sex = newSex;
                          });
                        },
                        value: _sex,
                      ),
                      new Padding(
                        padding: const EdgeInsets.only(top: 20.0),
                      ),
                      FloatingActionButton.extended(
                        label: Text('Register'),
                        backgroundColor:
                            Color.alphaBlend(Colors.green, Colors.green),
                        //onPressed: _submit,
                         onPressed: () async {
                    setState(() {
                      showSpinner = false;
                    });
                    try {
                      final newUser =
                          await _auth.createUserWithEmailAndPassword(
                              email: email, password: password);
                      if (newUser != null) {
                        _firestore.collection('users').document(email).setData({
                          'username': userName,
                        });
                       // Navigator.pushNamed(context, NearbyInterface.id);
                          //  Navigator.push(
                          //     context,
                          //     new MaterialPageRoute(
                          //         builder: (context) => new Tab_Bar()));
                          //  Navigator.pushNamed(context, '/login');
                           //  Navigator.push(context,
              //  new MaterialPageRoute(builder: (context) => new LoginView()));
                          Navigator.push(context,
                new MaterialPageRoute(builder: (context) => new NearbyInterface()));
                      }
                      setState(() {
                        showSpinner = false;
                      });
                    } catch (e) {
                      print(e);
                    }
                  },
                        // onPressed: () {
                        //   Navigator.push(
                        //       context,
                        //       new MaterialPageRoute(
                        //           builder: (context) => new Tab_Bar()));
                        // },
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
/*

class ProfileView extends StatelessWidget {
  const ProfileView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ProfileViewModel>.reactive(
      builder: (context, model, child) => Scaffold(
        body: Center(
          child: Text(model.title),
        ),
      ),
      viewModelBuilder: () => ProfileViewModel(),
    );
  }
}*/
