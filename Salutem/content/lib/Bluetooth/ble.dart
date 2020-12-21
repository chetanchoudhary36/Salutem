import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_scan_bluetooth_example/components/contact_card.dart';
import 'package:location/location.dart';
import 'package:nearby_connections/nearby_connections.dart';
import 'package:flutter_scan_bluetooth/flutter_scan_bluetooth.dart';

//import 'components/contact_card.dart';
//import 'constants.dart';




class BLE extends StatefulWidget {
//static const String id = 'ble';

  @override
  _BLEState createState() => new _BLEState();
}

class _BLEState extends State<BLE> {


 






String ddata='5C:E0:C5:8F:0A:DD';
  String _data = '';
  bool _scanning = false;
  FlutterScanBluetooth _bluetooth = FlutterScanBluetooth();
  Firestore _firestore = Firestore.instance;



// void Qqq(){
//  List list1 = [24, 'Hello', 84];
// List list2 = [11, 'Hi', 84];

// list1.forEach((list3) { list2.forEach((list4){

// if (list3==list4){
// print("trueeeeeeeee");
// }
// else{
//   print("falseeeeeee");
// }

// });



// });



// }


  @override
  void initState() {
    super.initState();

   


  //  WidgetsFlutterBinding.ensureInitialized();
  // Firebase.initializeApp();
  Timer.run(() => Aaaa());
  
 //Timer.periodic(Duration(seconds: 2), (Timer t) => Wwe());
    _bluetooth.devices.listen((device) {
      setState(() {
        _data =  '${device.address}';
               
         _firestore
        .collection('infected')
        .snapshots()
        .listen((snapshots) async {
      for (var doci in snapshots.documents) {
        String curri = doci.data['username'];
        if(_data==curri){
print('ookkkkkkkkkokokokokokoko');
  }else{
    print('nnnnnnnnnnnn');
    
  }
  }});
      });
      
    });
    // _bluetooth.scanStopped.listen((device) {
    //   setState(() {
    //     _scanning = false;
    //     _data += 'scan stopped\n';
    //   });
    // });
  }
// Wwe(){
//   if(_data==ddata){
// print('ooooooooooooooo');
//   }else{
//     print("_data");
//     print("ddata");
//   }
// }

  
// 5C:E0:C5:8F:0A:DD




 String contact_traced, studentID, studyProgramID;
  double studentGPA;
String user;
  getStudentName(_data) {
    this.user = _data;
  }

  getStudentID(_data) {
    this.studentID = _data;
  }

  getStudyProgramID(programID) {
    this.studyProgramID = programID;
  }

  getStudentGPA(gpa) {
    this.studentGPA = double.parse(gpa);
  }

  createData() {
    DocumentReference documentReference =
        Firestore.instance.collection("MyContacts").document(user);

    // create Map
    Map<String, dynamic> contact = {
      "User": user,
      //"studentID": studentID,
      //"studyProgramID": studyProgramID,
      //"studentGP": studentGPA
    };

    documentReference.setData(contact).whenComplete(() {
      print("$contact_traced created");
    });
  }

  // readData() {
  //   DocumentReference documentReference =
  //       Firestore.instance.collection("MyStudents").document(studentName);

  //   documentReference.get().then((datasnapshot) {
  //     print(datasnapshot.data["studentName"]);
  //     print(datasnapshot.data["studentID"]);
  //     print(datasnapshot.data["studyProgramID"]);
  //     print(datasnapshot.data["studentGPA"]);
  //   });
  // }

  updateData() {
    DocumentReference documentReference =
        Firestore.instance.collection("MyContacts").document(contact_traced);

    // create Map
    Map<String, dynamic> contact = {
      "User": contact_traced,
      "contact_traced": studentID,
     // "studyProgramID": studyProgramID,
     // "studentGP": studentGPA
    };

    documentReference.setData(contact).whenComplete(() {
      print("$contact_traced updated");
    });
  }

  deleteData() {
    DocumentReference documentReference =
        Firestore.instance.collection("MyStudents").document(contact_traced);

    documentReference.delete().whenComplete(() {
      print("$contact_traced deleted");
    });
  }

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










  @override
  Widget build(BuildContext context) {
  //  getStudentName(_data);
   //  getStudentID(_data);
    return Scaffold(
      appBar: AppBar(
        title: Text("My Flutter College"),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            Expanded(child: Text('_data')),
            
//             Padding(
//               padding: EdgeInsets.only(bottom: 8.0),
//               child: TextFormField(
//                 decoration: InputDecoration(
//                     labelText: "Name",
//                     fillColor: Colors.white,
//                     focusedBorder: OutlineInputBorder(
//                         borderSide:
//                             BorderSide(color: Colors.blue, width: 2.0))),
                
//               ),
//             ),
//             Padding(
//               padding: EdgeInsets.only(bottom: 8.0),
//               child: TextFormField(
//                 decoration: InputDecoration(
//                     labelText: "Student ID",
//                     fillColor: Colors.white,
//                     focusedBorder: OutlineInputBorder(
//                         borderSide:
//                             BorderSide(color: Colors.blue, width: 2.0))),
               
//               ),
//             ),
//             Padding(
//               padding: EdgeInsets.only(bottom: 8.0),
//               child: TextFormField(
//                 decoration: InputDecoration(
//                     labelText: "Study Program ID",
//                     fillColor: Colors.white,
//                     focusedBorder: OutlineInputBorder(
//                         borderSide:
//                             BorderSide(color: Colors.blue, width: 2.0))),
               
//               ),
//             ),
//             Padding(
//               padding: EdgeInsets.only(bottom: 8.0),
//               child: TextFormField(
//                 decoration: InputDecoration(
//                     labelText: "GPA",
//                     fillColor: Colors.white,
//                     focusedBorder: OutlineInputBorder(
//                         borderSide:
//                             BorderSide(color: Colors.blue, width: 2.0))),
                
//               ),
//             ),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//               children: <Widget>[
//                 RaisedButton(
//                   color: Colors.green,
//                   shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(16)),
//                   child: Text("Create"),
//                   textColor: Colors.white,
//                   onPressed: () {
//                     createData();
//                   },
//                 ),
                RaisedButton(
                  color: Colors.blue,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16)),
                  child: Text("Read"),
                  textColor: Colors.white,
                  onPressed: () {
                    createData();
                  },
                ),
//                 RaisedButton(
//                   color: Colors.orange,
//                   shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(16)),
//                   child: Text("Update"),
//                   textColor: Colors.white,
//                   onPressed: () {
//                     updateData();
//                   },
//                 ),
//                 RaisedButton(
//                   color: Colors.red,
//                   shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(16)),
//                   child: Text("Delete"),
//                   textColor: Colors.white,
//                   onPressed: () {
//                     deleteData();
//                   },
//                 )
//               ],
//             ),


//  Center(
//                 child: RaisedButton(
//                     // padding: EdgeInsets.only(bottom: 20.0, right: 10.0),
//                     color: Color.alphaBlend(Colors.green, Colors.green),
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(30.0),
//                       //side: BorderSide(color: Colors.red)
//                     ),
//                     child: Text(_scanning ? 'scan' : 'scan',
//                         style: TextStyle(
//                           fontFamily: 'Avenir',
//                           fontWeight: FontWeight.bold,
//                           fontSize: 15.0,
//                         )),
//                     onPressed: Qqq,
                                        
                                          
                    
                                          
//                                        // }
//                                         ),
//                                   ),

//             Padding(
//               padding: EdgeInsets.all(8.0),
//               child: Row(
//                 textDirection: TextDirection.ltr,
//                 children: <Widget>[
//                   Expanded(
//                     child: Text("Name"),
//                   ),
//                   Expanded(
//                     child: Text("Student ID"),
//                   ),
//                   Expanded(
//                     child: Text("Program ID"),
//                   ),
//                   Expanded(
//                     child: Text("GPA"),
//                   )
//                 ],
//               ),
//             ),
//             StreamBuilder(
//               stream: Firestore.instance.collection("MyStudents").snapshots(),
//               builder: (context, snapshot) {
//                 if (snapshot.hasData) {
//                   return ListView.builder(
//                       shrinkWrap: true,
//                       itemCount: snapshot.data.documents.length,
//                       itemBuilder: (context, index) {
//                         DocumentSnapshot documentSnapshot =
//                             snapshot.data.documents[index];
//                         // return Row(
//                         //   children: <Widget>[
//                         //     Expanded(
//                         //       child: Text(documentSnapshot["studentName"]),
//                         //     ),
//                         //     Expanded(
//                         //       child: Text(documentSnapshot["studentID"]),
//                         //     ),
//                         //     Expanded(
//                         //       child: Text(documentSnapshot["studyProgramID"]),
//                         //     ),
//                         //     Expanded(
//                         //       child: Text(
//                         //           documentSnapshot["studentGPA"].toString()),
//                         //     )
//                         //   ],
//                         // );
//                       });
//                 } else {
//                   return Align(
//                     alignment: FractionalOffset.bottomCenter,
//                     child: CircularProgressIndicator(),
//                   );
//                 }
//               },
//             )
          ],
        ),
      ),
    );
  }















  // @override
  // Widget build(BuildContext context) {
   
  //   return new MaterialApp(
  //     home: new Scaffold(
  //       appBar: new AppBar(
  //         title: const Text('Contact Tracing (Build1)'),
  //         backgroundColor: Color.alphaBlend(Colors.green, Colors.green),
  //       ),
  //       body: Column(
  //         mainAxisAlignment: MainAxisAlignment.start,
  //         children: <Widget>[
  //           Padding(padding: const EdgeInsets.only(top: 30.0)),
  //           Expanded(child: Text(_data)),
            
  //           Padding(
              
  //             padding: const EdgeInsets.all(10.0),
  //             child: Center(
  //               child: RaisedButton(
  //                   // padding: EdgeInsets.only(bottom: 20.0, right: 10.0),
  //                   color: Color.alphaBlend(Colors.green, Colors.green),
  //                   shape: RoundedRectangleBorder(
  //                     borderRadius: BorderRadius.circular(30.0),
  //                     //side: BorderSide(color: Colors.red)
  //                   ),
  //                   child: Text(_scanning ? 'scan' : 'scan',
  //                       style: TextStyle(
  //                         fontFamily: 'Avenir',
  //                         fontWeight: FontWeight.bold,
  //                         fontSize: 15.0,
  //                       )),
  //                   onPressed: Aaaa,
                                        
                                          
                    
                                          
  //                                      // }
  //                                       ),
  //                                 ),
  //                               )
  //                             ],
  //                           ),
  //                         ),
  //                       );
  //                     }
                    
                    
                    
                    
                    
                    
                    
                    
                      
                    

}
