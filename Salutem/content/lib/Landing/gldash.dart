import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_scan_bluetooth_example/Landing/home.dart';
import 'package:flutter_scan_bluetooth_example/Landing/tab_bar.dart';
import 'package:flutter_scan_bluetooth_example/components/gcontact.dart';
import 'package:location/location.dart';
import 'package:nearby_connections/nearby_connections.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

//import 'components/contact_card.dart';
//import 'constants.dart';

class Gldash extends StatefulWidget {
  static const String id = 'nearby_interface';

  @override
  _Gldash createState() => _Gldash();
}

class _Gldash extends State<Gldash> {
  Location location = Location();
  Firestore _firestore = Firestore.instance;
  final Strategy strategy = Strategy.P2P_STAR;
  FirebaseUser loggedInUser;
  String testText = '';
  final _auth = FirebaseAuth.instance;
  List<dynamic> contactTraces = [];
  List<dynamic> contactTimes = [];
  List<dynamic> contactLocations = [];
  List<dynamic> contactres = [];
  
 bool _scanning = false;

FlutterLocalNotificationsPlugin fltrNotification;










  void addContactsToList() async {
   // await getCurrentUser();

    _firestore
        .collection('schedule')
       // .document('zxcvbn@gmail.com')
       // .collection('met_with')
        .snapshots()
        .listen((snapshot) {
      for (var doc in snapshot.documents) {
        String currUsername = doc.data['company'];
                    String currRes = doc.data['room'];
        DateTime currTime = doc.data.containsKey('contact time')
            ? (doc.data['contact time'] as Timestamp).toDate()
            : null;
        String currLocation = doc.data.containsKey('contact location')
            ? doc.data['contact location']
            : null;

        if (!contactTraces.contains(currUsername)) {
                contactres.add(currRes);
          contactTraces.add(currUsername);
          contactTimes.add(currTime);
          contactLocations.add(currLocation);
        }
      }
      setState(() {});
      print(loggedInUser.email);
    });
  }




  @override
  void initState() {
    super.initState();

  var androidInitilize = new AndroidInitializationSettings('app_icon');
  var iOSinitilize = new IOSInitializationSettings();
  var initilizationsSettings =
      new InitializationSettings(androidInitilize, iOSinitilize);
  fltrNotification = new FlutterLocalNotificationsPlugin();
  
    addContactsToList();
 
  }





  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
     
        centerTitle: true,
        title: Text(
          'Scheduled Events',
          style: TextStyle(
            color: Colors.green[800],
            fontWeight: FontWeight.bold,
            fontSize: 28.0,
          ),
        ),
        backgroundColor: Colors.green[100],
      ),
      body: Column(
        children: <Widget>[
         

          Expanded(
            flex: 2,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 25.0),
              child: ListView.builder(
                itemBuilder: (context, index) {
                  


                 
                 int aa=5;
               


                  return Gcontact(

                        

                    imagePath: 'lib/assets/user.png',
                    email: contactTraces[index],
                   
                    infection: 'Scheduled Sanitization',
                    //contactres[index],
                    //data["res"].toString(),
                    
                    
                    contactUsername: contactTraces[index],
                    contactTime: contactTimes[index],
                   // contactLocation: contactres[index],
                    
                  );
                },
                itemCount: contactTraces.length,
              ),
            ),
          ),



        ],
        
      ),
      
    );
 
  }


  
}


