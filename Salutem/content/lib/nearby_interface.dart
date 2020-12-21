import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_scan_bluetooth_example/Landing/home.dart';
import 'package:flutter_scan_bluetooth_example/Landing/tab_bar.dart';
import 'package:location/location.dart';
import 'package:nearby_connections/nearby_connections.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:flutter_scan_bluetooth/flutter_scan_bluetooth.dart';

import 'components/contact_card.dart';
import 'constants.dart';

class NearbyInterface extends StatefulWidget {
  static const String id = 'nearby_interface';

  @override
  _NearbyInterfaceState createState() => _NearbyInterfaceState();
}

class _NearbyInterfaceState extends State<NearbyInterface> {
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

  String ddata='5C:E0:C5:8F:0A:DD';
  String _data = '';
  //bool _scanning = false;
  FlutterScanBluetooth _bluetooth = FlutterScanBluetooth();
 // Firestore _firestore = Firestore.instance;
  
 bool _scanning = false;

FlutterLocalNotificationsPlugin fltrNotification;


Map datac;
Map datar;


void qqq(){

_firestore
        .collection('users')
        .document(loggedInUser.email)
        .collection('met_with')
        .snapshots()
        .listen((snapshot) {
      for (var doc in snapshot.documents) {
        String curr = doc.data['username'];

        _firestore
        .collection('infected')
        .snapshots()
        .listen((snapshots) async {
      for (var doci in snapshots.documents) {
        String curri = doci.data['username'];

if(curr==curri){


var androidDetails = new AndroidNotificationDetails(
      "Channel ID", "Desi programmer", "This is my channel",
      importance: Importance.Max);
  var iSODetails = new IOSNotificationDetails();
  var generalNotificationDetails =
      new NotificationDetails(androidDetails, iSODetails);

   await fltrNotification.show(
       0, "Warning", "You Met With Infected User", 
       generalNotificationDetails, payload: "Get Quarentined And Get Tested You Met With Infected User");

  print('ttttttttttttttttttt');
}else{
  print('fffffffffffffffffffff');
}
        
      }});

      }});


}



// void resaddContactsToList() async {
//     await getCurrentUser();

//     _firestore
//         .collection('users')
//         .where("username", isEqualTo: contactTraces)
//         .snapshots()
//         .listen((snapshot) {
//       for (var doc in snapshot.documents) {
//         String currUsername = doc.data['username'];
//         String currRes = doc.data['res'];
//         DateTime currTime = doc.data.containsKey('contact time')
//             ? (doc.data['contact time'] as Timestamp).toDate()
//             : null;
//         String currLocation = doc.data.containsKey('contact location')
//             ? doc.data['contact location']
//             : null;

//         if (!contactTraces.contains(currUsername)) {
//           contactres.add(currRes);
//           contactTraces.add(currUsername);
//           contactTimes.add(currTime);
//           contactLocations.add(currLocation);
//         }
//       }
//       setState(() {});
//       print(loggedInUser.email);
//     });
//   }


  void addContactsToList() async {
    await getCurrentUser();

    _firestore
        .collection('users')
        .document(loggedInUser.email)
        .collection('met_with')
        .snapshots()
        .listen((snapshot) {
      for (var doc in snapshot.documents) {
        String currUsername = doc.data['username'];
       // String currRes = doc.data['res'];
        DateTime currTime = doc.data.containsKey('contact time')
            ? (doc.data['contact time'] as Timestamp).toDate()
            : null;
        String currLocation = doc.data.containsKey('contact location')
            ? doc.data['contact location']
            : null;

        if (!contactTraces.contains(currUsername)) {
        //  contactres.add(currRes);
          contactTraces.add(currUsername);
          contactTimes.add(currTime);
          contactLocations.add(currLocation);
        }
      }
      setState(() {});
      print(loggedInUser.email);
    });
  }

  void deleteOldContacts(int threshold) async {
    await getCurrentUser();
    DateTime timeNow = DateTime.now(); //get today's time

    _firestore
        .collection('users')
        .document(loggedInUser.email)
        .collection('met_with')
        .snapshots()
        .listen((snapshot) {
      for (var doc in snapshot.documents) {
//        print(doc.data.containsKey('contact time'));
        if (doc.data.containsKey('contact time')) {
          DateTime contactTime = (doc.data['contact time'] as Timestamp)
              .toDate(); // get last contact time
          // if time since contact is greater than threshold than remove the contact
          if (timeNow.difference(contactTime).inDays > threshold) {
            doc.reference.delete();
          }
        }
      }
    });

    setState(() {});
  }

  void discovery() async {
    try {
      bool a = await Nearby().startDiscovery(loggedInUser.email, strategy,
          onEndpointFound: (id, name, serviceId) async {
        print('I saw id:$id with name:$name'); // the name here is an email

        var docRef =
            _firestore.collection('users').document(loggedInUser.email);

        //  When I discover someone I will see their email and add that email to the database of my contacts
        //  also get the current time & location and add it to the database
        docRef.collection('met_with').document(name).setData({
          'username': await getUsernameOfEmail(email: name),
          'contact time': DateTime.now(),
          'contact location': (await location.getLocation()).toString(),
        });
      }, onEndpointLost: (id) {
        print(id);
      });
      print('DISCOVERING: ${a.toString()}');
    } catch (e) {
      print(e);
    }
  }

  void getPermissions() {
    Nearby().askLocationAndExternalStoragePermission();
  }

  Future<String> getUsernameOfEmail({String email}) async {
    String res = '';
    await _firestore.collection('users').document(email).get().then((doc) {
      if (doc.exists) {
        res = doc.data['username'];
      } else {
        // doc.data() will be undefined in this case
        print("No such document!");
      }
    });
    return res;
  }

  Future<void> getCurrentUser() async {
    try {
      final user = await _auth.currentUser();
      if (user != null) {
        loggedInUser = user;
      }
    } catch (e) {
      print(e);
    }
  }


Future notificationSelected(String payload) async {
  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      content: Text("Notification : $payload"),
    ),
  );
}


  @override
  void initState() {
    super.initState();

  var androidInitilize = new AndroidInitializationSettings('app_icon');
  var iOSinitilize = new IOSInitializationSettings();
  var initilizationsSettings =
      new InitializationSettings(androidInitilize, iOSinitilize);
  fltrNotification = new FlutterLocalNotificationsPlugin();
  fltrNotification.initialize(initilizationsSettings,
      onSelectNotification: notificationSelected);



  //_onAlertButtonPressed(context);
    deleteOldContacts(14);
    addContactsToList();
    getPermissions();
    Timer.run(() => _showDialog());
  //  qwer();
    Timer.run(() => qwer());
    Timer.periodic(Duration(seconds: 18), (Timer t) => qqq());
   Timer.periodic(Duration(seconds: 10), (Timer t) => fetchData());
 // Timer.run(() => discovery());

  Timer.run(() => Aaaa());
  
 //Timer.periodic(Duration(seconds: 2), (Timer t) => Wwe());
    _bluetooth.devices.listen((device) {
      setState(() {
        _data =  '${device.address}';
               
         _firestore
        .collection('MyContacts')
        .snapshots()
        .listen((snapshots) async {
      for (var doci in snapshots.documents) {
        String curri = doci.data['user'];
        if(curri==_data){
              _firestore.collection('roomets').document(loggedInUser.email).setData({
                         'username': await getUsernameOfEmail(email: loggedInUser.email),
                          'roommac': curri
                         
                });
        //  Eeee();
print('ookkkkkkkkkokokokokokoko');

  }else{
    print('nnnnnnnnnnnn');
    
  }
  }});
      });
      
    });

  }

//  Future<void> Eeee() async{
//     _firestore.collection('infected').document(loggedInUser.email).setData({
//                          'username': await getUsernameOfEmail(email: loggedInUser.email)
//                 });
//   }


                        Future<void> Aaaa() async {
                        try {
                                            if (_scanning) {
                                              await _bluetooth.startScan(pairedDevices: false);
                                              debugPrint("scanning started");
                                              setState(() {
                                                _scanning = true;
                                              });
                                             // createData();
                                            } else {
                                              await _bluetooth.startScan(pairedDevices: false);
                                              debugPrint("scanning started");
                                              setState(() {
                                                _scanning = true;
                                              });
                                            //  createData();
                                            }
                                          } on PlatformException catch (e) {
                                            debugPrint(e.toString());
                                          }
  }



//   _onAlertButtonPressed(context) {
//     Alert(
//       context: context,
//       type: AlertType.error,
//       title: "RFLUTTER ALERT",
//       desc: "Flutter is more awesome with RFlutter Alert.",
//       buttons: [
//         DialogButton(
//           child: Text(
//             "COOL",
//             style: TextStyle(color: Colors.white, fontSize: 20),
//           ),
//           onPressed: () {},
//           width: 120,
//         )
//       ],
//     ).show();
//   }

void qwer(){
Stream<QuerySnapshot> list1 =     Firestore.instance.collection('users').document(loggedInUser.email).collection('met_with').snapshots();
Stream<QuerySnapshot> list2 = Firestore.instance.collection('infected').snapshots();
print(list1);
print(list2);
list1.forEach((list3) { list2.forEach((list4){

if (list3==list4){
print("trueeeeeeeee");
}
else{
  print("falseeeeeee");
}

});



});
 }


// start() async {
//   try {
//                   bool a = await Nearby().startAdvertising(
//                     loggedInUser.email,
//                     strategy,
//                     onConnectionInitiated: null,
//                     onConnectionResult: (id, status) {
//                       print(status);
//                     },
//                     onDisconnected: (id) {
//                       print('Disconnected $id');
//                     },
//                   );

//                   print('ADVERTISING ${a.toString()}');
//                 } catch (e) {
//                   print(e);
//                 }
//                 discovery();
// }


//Map data;
//  fetchData() async {
//    //int index;

// var result = await Firestore.instance.collection("users")
//       .where("username", isEqualTo: "qwqwqw")
//       .getDocuments();
//   result.documents.forEach((res) {
//     print(res.data);
//     setState(() {
// data=res.data;
// print(data);
//  });
//   });

fetchData(){
  
  

//   Query collectionReference = Firestore.instance.collection('users').where("username", isEqualTo: contactTraces[0]);
//   collectionReference.snapshots().listen((snapshot) {
//     setState(() {
//   data=snapshot.documents[0].data;
// }); 
//   });
  
//  _firestore.collection('qwert')
//      .getDocuments().then((snapshot){
//        data = snapshot.documents[0]["name"];
//   print(data);
//       setState(() {
//   data = snapshot.documents[0]["name"];
//   print(data);
 
// });


//      });

    //  print("rwwwqqqqqqqqqqqqqq");
    //  print(data);
//   int index;



_firestore
        .collection('roomets')
       // .document(loggedInUser.email)
     //   .collection('met_with')
        .snapshots()
        .listen((snapshot) {
      for (var doc in snapshot.documents) {
        String curru = doc.data['username'];

        _firestore
        .collection('infected')
        .snapshots()
        .listen((snapshots) async {
      for (var doci in snapshots.documents) {
        String currit = doci.data['username'];

if(curru==currit){


  _firestore
        .collection('roomets').where('username', isEqualTo: curru).snapshots().listen((snapshot) {
 setState(() {
   datac=snapshot.documents[0].data;
   print(datac);
   print('1rrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrr');
   });
//print(datar);
print('2rrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrr');
 print(datac);

   _firestore
        .collection('MyContacts').where('user', isEqualTo: datac["roommac"]).snapshots().listen((snapshot) {
 setState(() {
   datar=snapshot.documents[0].data;
   print(datar);
   print('4rrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrr');
   });
//print(datar);
print('5rrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrr');
 print(datar);

 _firestore.collection('schedule').document(datar["company"]).setData({
                         'company': datar["company"]
                });

   });
   });
   print(datar);
   print('3rrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrr');

   
}else{
  print('ccccccccccccccccccccccccccccccccccccc');
}
        
      }});

      }});


//  String datar;
//    CollectionReference collectionReferencer = Firestore.instance.collection('MyContacts');
//    collectionReferencer.where('user', isEqualTo: data).snapshots().listen((snapshot) {
//  setState(() {
//    datar=snapshot.documents[0]['company'].data;
//  }); 
//  print(datar);
//    });

}


  void testresult() {
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text("If You Got Tested COVID Positive"),
          content: new Text("Click Yes To Mark Yourself As COVID Positive"),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            new FlatButton(
              child: new Text("YES"),
              onPressed: () async {
                 _firestore.collection('infected').document(loggedInUser.email).setData({
                         'username': await getUsernameOfEmail(email: loggedInUser.email)
                });

                 Navigator.of(context).pop();
               
              },
            ),
            new FlatButton(
              child: new Text("NO"),
              onPressed: () async {
                  Navigator.of(context).pop();
               
              },
            ),
          ],
        );
      },
    );
  }

  

  void _showDialog() {
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text("Start Your Contact tracing"),
          content: new Text("Click on Start For Covid Protect & Wait"),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            new FlatButton(
              child: new Text("Start"),
              onPressed: () async {
                Navigator.of(context).pop();
                try {
                  
                  bool a = await Nearby().startAdvertising(
                    loggedInUser.email,
                    strategy,
                    onConnectionInitiated: null,
                    onConnectionResult: (id, status) {
                      print(status);
                    },
                    onDisconnected: (id) {
                      print('Disconnected $id');
                    },
                  );

                  print('ADVERTISING ${a.toString()}');
                } catch (e) {
                  print(e);
                }
                discovery();
               // Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Icon(
          Icons.menu,
          color: Colors.red[800],
        ),
        centerTitle: true,
        title: Text(
          'Traced Contacts',
          style: TextStyle(
            color: Colors.red[800],
            fontWeight: FontWeight.bold,
            fontSize: 28.0,
          ),
        ),
        backgroundColor: Colors.red[100],
      ),
      body: Column(
        children: <Widget>[
          // Expanded(
          //   child: Padding(
          //     padding: EdgeInsets.only(
          //       left: 25.0,
          //       right: 25.0,
          //       bottom: 10.0,
          //       top: 30.0,
          //     ),
          //     child: Container(
          //       height: 100.0,
          //       width: double.infinity,
          //       decoration: BoxDecoration(
          //         color: Colors.red[500],
          //         borderRadius: BorderRadius.circular(20.0),
          //         boxShadow: [
          //           BoxShadow(
          //             color: Colors.black,
          //             blurRadius: 4.0,
          //             spreadRadius: 0.0,
          //             offset:
          //                 Offset(2.0, 2.0), // shadow direction: bottom right
          //           )
          //         ],
          //       ),
          //       child: Row(
          //         children: <Widget>[
          //           Expanded(
          //             child: Image(
          //               image: AssetImage('images/corona.png'),
          //             ),
          //           ),
          //           Expanded(
          //             flex: 2,
          //             child: Text(
          //               'contacted users',
          //               textAlign: TextAlign.left,
          //               style: TextStyle(
          //                 fontSize: 21.0,
          //                 color: Colors.white,
          //                 fontWeight: FontWeight.w500,
          //               ),
          //             ),
          //           )
          //         ],
          //       ),
          //     ),
          //   ),
          // ),

          Expanded(
            flex: 2,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 25.0),
              child: ListView.builder(
                itemBuilder: (context, index) {
                  
//  Query collectionReference = Firestore.instance.collection('users').where("username", isEqualTo: contactTraces[index]);
//   collectionReference.snapshots().listen((snapshot) {
//     setState(() {
//   data=snapshot.documents[0].data;
// }); 
//   });

//                   Future fetchData() async {
//                     var result = await Firestore.instance.collection("users")
//       .where("username", isEqualTo: "qwqwqw")
//       .getDocuments();
//   result.documents.forEach((res) {
//     print(res.data);
//     setState(() {
// data=res.data;
// print(data);
//  });
//   });

                 // }
                 int aa=5;
                // print('------------------------------------------------------------------------');
//print(contactTraces[index]);
//print('------------------------------------------------------------------------');
 //setState(() {});
_firestore
        .collection('users')
       // .where("username", isEqualTo: contactTraces[index])
        .snapshots()
        .listen((snapshot) {
      for (var doc in snapshot.documents) {
       // String currUsername = doc.data['username'];
        String currRes = doc.data['res'];
       // DateTime currTime = doc.data.containsKey('contact time')
       //     ? (doc.data['contact time'] as Timestamp).toDate()
        //    : null;
        //String currLocation = doc.data.containsKey('contact location')
        //    ? doc.data['contact location']
        //    : null;

        if (aa==5) {
          contactres.add(currRes);
         // contactTraces.add(currUsername);
          //contactTimes.add(currTime);
          //contactLocations.add(currLocation);
        }
      }
      setState(() {});
    // print(contactTraces[index]);
   // print(contactTraces[index]);
   //   print(loggedInUser.email);
    });


                  return ContactCard(

                        

                    imagePath: 'lib/assets/user.png',
                    email: contactTraces[index],
                   
                    infection: 'contacteds',
                    //datar["company"],
                    //datac["roommac"].toString(),
                    //'Not Infected',
                    //contactres[index],
                    //data["res"].toString(),
                    
                    
                    contactUsername: contactTraces[index],
                    contactTime: contactTimes[index],
                    contactLocation: contactLocations[index],
                    
                  );
                },
                itemCount: contactTraces.length,
              ),
            ),
          ),


Padding(
            padding: EdgeInsets.only(bottom: 30.0),
            child: RaisedButton(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0)),
              elevation: 5.0,
              color: Colors.red[400],
              onPressed: () 
              async 
              {
                testresult();
 // _firestore.collection('infected').document(loggedInUser.email).setData({
                     //    'username': await getUsernameOfEmail(email: loggedInUser.email)
              //  });

   },
              child: Text(
                'Got Tested COVID Positive',
                style: kButtonTextStyle,
              ),
            ),
          ),

                  Padding(
            padding: EdgeInsets.only(bottom: 30.0),
            child: RaisedButton(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0)),
              elevation: 5.0,
              color: Colors.red[400],
              onPressed: () 
              async 
              {
// Stream list1 =     Firestore.instance
//         .collection('users')
//         .document(loggedInUser.email)
//         .collection('met_with')
//         .snapshots();
// Stream list2 = Firestore.instance
//         .collection('qwert').snapshots();

// list1.forEach((list3) { list2.forEach((list4){

// if (list3==list4){
// print("trueeeeeeeee");
// }
// else{
//   print("falseeeeeee");
// }

// });



// });

// try {
                //   bool a = await Nearby().startAdvertising(
                //     loggedInUser.email,
                //     strategy,
                //     onConnectionInitiated: null,
                //     onConnectionResult: (id, status) {
                //       print(status);
                //     },
                //     onDisconnected: (id) {
                //       print('Disconnected $id');
                //     },
                //   );

                //   print('ADVERTISING ${a.toString()}');
                // } catch (e) {
                //   print(e);
                // }
                // discovery();




// var androidDetails = new AndroidNotificationDetails(
//       "Channel ID", "Desi programmer", "This is my channel",
//       importance: Importance.Max);
//   var iSODetails = new IOSNotificationDetails();
//   var generalNotificationDetails =
//       new NotificationDetails(androidDetails, iSODetails);

//    await fltrNotification.show(
//        0, "Task", "You created a Task", 
//        generalNotificationDetails, payload: "Task");


// var androidChannelSpecifics = AndroidNotificationDetails(
//       'CHANNEL_ID',
//       'CHANNEL_NAME',
//       "CHANNEL_DESCRIPTION",
//       importance: Importance.Max,
//       priority: Priority.High,
//       playSound: true,
//       timeoutAfter: 5000,
//       styleInformation: DefaultStyleInformation(true, true),
//     );
//     var iosChannelSpecifics = IOSNotificationDetails();
//     var platformChannelSpecifics =
//         NotificationDetails(androidChannelSpecifics, iosChannelSpecifics);
//     await flutterLocalNotificationsPlugin.show(
//       0,  // Notification ID
//       'Test Title', // Notification Title
//       'Test Body', // Notification Body, set as null to remove the body
//       platformChannelSpecifics,
//       payload: 'New Payload', // Notification Payload
//     );




Navigator.push(context,
                new MaterialPageRoute(builder: (context) => new Tab_Bar()));
//Navigator.pushNamed(context, Home);
// Stream<QuerySnapshot> list1 = Firestore.instance.collection('users').document(loggedInUser.email).collection('met_with').snapshots();
// Stream<QuerySnapshot> list2 = Firestore.instance.collection('infected').snapshots();
// print(list1);
// print(list2);


                
              },
              child: Text(
                'Move To Home Screen',
                style: kButtonTextStyle,
              ),
            ),
          ),



















          // Padding(
          //     padding: const EdgeInsets.all(8.0),
          //     child: Center(
          //                       child: RaisedButton(child: Text(_scanning ? 'Stop scan' : 'Start scan'), onPressed: () async {
          //         try {
          //           if(_scanning) {
          //              bool a = await Nearby().startAdvertising(
          //           loggedInUser.email,
          //           strategy,
          //           onConnectionInitiated: null,
          //           onConnectionResult: (id, status) {
          //             print(status);
          //           },
          //           onDisconnected: (id) {
          //             print('Disconnected $id');
          //           },
          //         );

          //         print('ADVERTISING ${a.toString()}');
          //             setState(() {
          //               //_data = '';
          //             });
          //           }
          //           else {
          //             Navigator.pushNamed(context, '/tab-bar');
          //             setState(() {
          //               _scanning = true;
          //             });
          //           }
          //         }  catch (e) {
          //           debugPrint(e.toString());
          //         }
          //       }),
          //     ),
          //   )
        ],
        
      ),
      
    );
 
  }


  
}


