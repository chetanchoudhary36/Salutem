// import 'dart:async';

// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
// import 'package:location/location.dart';
// import 'package:nearby_connections/nearby_connections.dart';
// import 'package:rflutter_alert/rflutter_alert.dart';

// import 'components/contact_card.dart';
// import 'constants.dart';

// class Testresult extends StatefulWidget {
//   //const Testresult({Key key}) : super(key: key);

//   @override
//   _Testresult createState() => _Testresult();
// }

// class _Testresult extends State<Testresult> {
//  Location location = Location();
//   Firestore _firestore = Firestore.instance;
//   final Strategy strategy = Strategy.P2P_STAR;
//   FirebaseUser loggedInUser;
//   String testText = '';
//   final _auth = FirebaseAuth.instance;
//   List<dynamic> contactTraces = [];
//   List<dynamic> contactTimes = [];
//   List<dynamic> contactLocations = [];
//   List<dynamic> contactres = [];
  
//  bool _scanning = false;

// FlutterLocalNotificationsPlugin fltrNotification;



//   createData() {
//     DocumentReference documentReference =
//         Firestore.instance.collection("infected").document(loggedInUser.email);

//     // create Map
//     Map<String, dynamic> contact = {
//       "User": 'user'
//       //"studentID": studentID,
//       //"studyProgramID": studyProgramID,
//       //"studentGP": studentGPA
//     };

//     documentReference.setData(contact).whenComplete(() {
//       print("created");
//     });
//   }


// void qqq(){

// _firestore
//         .collection('users')
//         .document(loggedInUser.email)
//         .collection('met_with')
//         .snapshots()
//         .listen((snapshot) {
//       for (var doc in snapshot.documents) {
//         String curr = doc.data['username'];

//         _firestore
//         .collection('infected')
//         .snapshots()
//         .listen((snapshots) async {
//       for (var doci in snapshots.documents) {
//         String curri = doci.data['username'];

// if(curr==curri){


// var androidDetails = new AndroidNotificationDetails(
//       "Channel ID", "Desi programmer", "This is my channel",
//       importance: Importance.Max);
//   var iSODetails = new IOSNotificationDetails();
//   var generalNotificationDetails =
//       new NotificationDetails(androidDetails, iSODetails);

//    await fltrNotification.show(
//        0, "Warning", "You Met With Infected User", 
//        generalNotificationDetails, payload: "Get Quarentined And Get Tested You Met With Infected User");

//   print('ttttttttttttttttttt');
// }else{
//   print('fffffffffffffffffffff');
// }
        
//       }});

//       }});


// }



// // void resaddContactsToList() async {
// //     await getCurrentUser();

// //     _firestore
// //         .collection('users')
// //         .where("username", isEqualTo: contactTraces)
// //         .snapshots()
// //         .listen((snapshot) {
// //       for (var doc in snapshot.documents) {
// //         String currUsername = doc.data['username'];
// //         String currRes = doc.data['res'];
// //         DateTime currTime = doc.data.containsKey('contact time')
// //             ? (doc.data['contact time'] as Timestamp).toDate()
// //             : null;
// //         String currLocation = doc.data.containsKey('contact location')
// //             ? doc.data['contact location']
// //             : null;

// //         if (!contactTraces.contains(currUsername)) {
// //           contactres.add(currRes);
// //           contactTraces.add(currUsername);
// //           contactTimes.add(currTime);
// //           contactLocations.add(currLocation);
// //         }
// //       }
// //       setState(() {});
// //       print(loggedInUser.email);
// //     });
// //   }


//   void addContactsToList() async {
//     await getCurrentUser();

//     _firestore
//         .collection('users')
//         .document(loggedInUser.email)
//         .collection('met_with')
//         .snapshots()
//         .listen((snapshot) {
//       for (var doc in snapshot.documents) {
//         String currUsername = doc.data['username'];
//        // String currRes = doc.data['res'];
//         DateTime currTime = doc.data.containsKey('contact time')
//             ? (doc.data['contact time'] as Timestamp).toDate()
//             : null;
//         String currLocation = doc.data.containsKey('contact location')
//             ? doc.data['contact location']
//             : null;

//         if (!contactTraces.contains(currUsername)) {
//         //  contactres.add(currRes);
//           contactTraces.add(currUsername);
//           contactTimes.add(currTime);
//           contactLocations.add(currLocation);
//         }
//       }
//       setState(() {});
//       print(loggedInUser.email);
//     });
//   }

//   void deleteOldContacts(int threshold) async {
//     await getCurrentUser();
//     DateTime timeNow = DateTime.now(); //get today's time

//     _firestore
//         .collection('users')
//         .document(loggedInUser.email)
//         .collection('met_with')
//         .snapshots()
//         .listen((snapshot) {
//       for (var doc in snapshot.documents) {
// //        print(doc.data.containsKey('contact time'));
//         if (doc.data.containsKey('contact time')) {
//           DateTime contactTime = (doc.data['contact time'] as Timestamp)
//               .toDate(); // get last contact time
//           // if time since contact is greater than threshold than remove the contact
//           if (timeNow.difference(contactTime).inDays > threshold) {
//             doc.reference.delete();
//           }
//         }
//       }
//     });

//     setState(() {});
//   }

//   void discovery() async {
//   //  try {
//      // bool a = await Nearby().startDiscovery(loggedInUser.email, strategy,
//        //   onEndpointFound: (id, name, serviceId) async {
//      //   print('I saw id:$id with name:$name'); // the name here is an email
// print(loggedInUser.email);
//         var docRef =
//             _firestore.collection('infected').document(loggedInUser.email);

//         //  When I discover someone I will see their email and add that email to the database of my contacts
//         //  also get the current time & location and add it to the database
//         docRef.setData ({
//           'username': await getUsernameOfEmail(email: loggedInUser.email),
//          // 'contact time': DateTime.now(),
//          // 'contact location': (await location.getLocation()).toString(),
//        // });
//      // }, onEndpointLost: (id) {
//     //    print(id);
//       });
//      // print('DISCOVERING: ${a.toString()}');
//     }// catch (e) {
//      // print(e);
//    // }
//  // }

//   void getPermissions() {
//     Nearby().askLocationAndExternalStoragePermission();
//   }

//   Future<String> getUsernameOfEmail({String email}) async {
//     String res = '';
//     await _firestore.collection('users').document(email).get().then((doc) {
//       if (doc.exists) {
//         res = doc.data['username'];
//       } else {
//         // doc.data() will be undefined in this case
//         print("No such document!");
//       }
//     });
//     return res;
//   }

//   Future<void> getCurrentUser() async {
//     try {
//       final user = await _auth.currentUser();
//       if (user != null) {
//         loggedInUser = user;
//       }
//     } catch (e) {
//       print(e);
//     }
//   }


// Future notificationSelected(String payload) async {
//   showDialog(
//     context: context,
//     builder: (context) => AlertDialog(
//       content: Text("Notification : $payload"),
//     ),
//   );
// }


//   @override
//   void initState() {
//     super.initState();

//   // var androidInitilize = new AndroidInitializationSettings('app_icon');
//   // var iOSinitilize = new IOSInitializationSettings();
//   // var initilizationsSettings =
//   //     new InitializationSettings(androidInitilize, iOSinitilize);
//   // fltrNotification = new FlutterLocalNotificationsPlugin();
//   // fltrNotification.initialize(initilizationsSettings,
//   //     onSelectNotification: notificationSelected);



//   // //_onAlertButtonPressed(context);
//   //   deleteOldContacts(14);
//   //   addContactsToList();
//   //   getPermissions();
//   //   Timer.run(() => _showDialog());
//   // //  qwer();
//   //   Timer.run(() => qwer());
//   //   Timer.periodic(Duration(seconds: 18), (Timer t) => qqq());
//   // Timer.run(Duration(seconds: 18), (Timer t) => discovery());
//  // Timer.run(() => discovery());
//   }



// //   _onAlertButtonPressed(context) {
// //     Alert(
// //       context: context,
// //       type: AlertType.error,
// //       title: "RFLUTTER ALERT",
// //       desc: "Flutter is more awesome with RFlutter Alert.",
// //       buttons: [
// //         DialogButton(
// //           child: Text(
// //             "COOL",
// //             style: TextStyle(color: Colors.white, fontSize: 20),
// //           ),
// //           onPressed: () {},
// //           width: 120,
// //         )
// //       ],
// //     ).show();
// //   }

// void qwer(){
// Stream<QuerySnapshot> list1 =     Firestore.instance.collection('users').document(loggedInUser.email).collection('met_with').snapshots();
// Stream<QuerySnapshot> list2 = Firestore.instance.collection('infected').snapshots();
// print(list1);
// print(list2);
// list1.forEach((list3) { list2.forEach((list4){

// if (list3==list4){
// print("trueeeeeeeee");
// }
// else{
//   print("falseeeeeee");
// }

// });



// });
//  }


// // start() async {
// //   try {
// //                   bool a = await Nearby().startAdvertising(
// //                     loggedInUser.email,
// //                     strategy,
// //                     onConnectionInitiated: null,
// //                     onConnectionResult: (id, status) {
// //                       print(status);
// //                     },
// //                     onDisconnected: (id) {
// //                       print('Disconnected $id');
// //                     },
// //                   );

// //                   print('ADVERTISING ${a.toString()}');
// //                 } catch (e) {
// //                   print(e);
// //                 }
// //                 discovery();
// // }


// //Map data;
// //  fetchData() async {
// //    //int index;

// // var result = await Firestore.instance.collection("users")
// //       .where("username", isEqualTo: "qwqwqw")
// //       .getDocuments();
// //   result.documents.forEach((res) {
// //     print(res.data);
// //     setState(() {
// // data=res.data;
// // print(data);
// //  });
// //   });

// //fetchData(){
  
  

// //   Query collectionReference = Firestore.instance.collection('users').where("username", isEqualTo: contactTraces[0]);
// //   collectionReference.snapshots().listen((snapshot) {
// //     setState(() {
// //   data=snapshot.documents[0].data;
// // }); 
// //   });
  
// //  _firestore.collection('qwert')
// //      .getDocuments().then((snapshot){
// //        data = snapshot.documents[0]["name"];
// //   print(data);
// //       setState(() {
// //   data = snapshot.documents[0]["name"];
// //   print(data);
 
// // });


// //      });

//     //  print("rwwwqqqqqqqqqqqqqq");
//     //  print(data);
// //   int index;
// //   CollectionReference collectionReference = Firestore.instance.collection('users');
// //   collectionReference.where('username', isEqualTo: contactTraces[index]).snapshots().listen((snapshot) {
// // setState(() {
// //   data=snapshot.documents[0]['res'].data;
// // }); 
// //   });

// //}



//   @override
//   Widget build(BuildContext context) {
//     return Center(
//       child: Column(
//         children: <Widget>[
//           // children: Center(
//              Padding(
//             padding: EdgeInsets.only(bottom: 30.0),
//             // child: Text("Have You Done Covid Test And Got Tested Positive"
//             //   shape: RoundedRectangleBorder(
//             //       borderRadius: BorderRadius.circular(20.0)),
//             //   elevation: 5.0,
//             //   color: Colors.red[400],
//             //   onPressed: () 
//             //   async 
//             //   {
//             //       },
//               child: Text(
//                 "Have You Done Covid Test And Got Tested Positive",
//                // style: kButtonTextStyle,
//               ),
//             ),
//          // ),
//          Padding(
//             padding: EdgeInsets.only(bottom: 30.0),
//             child: RaisedButton(
//               shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(20.0)),
//               elevation: 5.0,
//               color: Colors.red[400],
//               onPressed: () 
//               async 
//               {
//               //  print(loggedInUser.email);
// //createData();
//                 _firestore.collection('infected').document(loggedInUser.email).setData({
//                          'username': await getUsernameOfEmail(email: loggedInUser.email)
//                 });
//                   },
//               child: Text(
//                 'Yes Got Tested Positive',
//                // style: kButtonTextStyle,
//               ),
//             ),
//           ),
//                                Padding(
//             padding: EdgeInsets.only(bottom: 30.0),
//             child: RaisedButton(
//               shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(20.0)),
//               elevation: 5.0,
//               color: Colors.red[400],
//               onPressed: () 
//               async 
//               {
//                   },
//               child: Text(
//                 'Not At All',
//                // style: kButtonTextStyle,
//               ),
//             ),
//           ),
//                     ],
//                   ),
//                 );
//               }
  
// }