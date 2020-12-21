import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_scan_bluetooth_example/apis/corona_service.dart';
import 'package:flutter_scan_bluetooth_example/models/corona_case_country.dart';
import 'package:flutter_scan_bluetooth_example/models/corona_case_total_count.dart';
import 'package:flutter_scan_bluetooth_example/utils/utils.dart';
import 'package:charts_flutter/flutter.dart' as charts;

class HelpContent extends StatefulWidget {
  HelpContent(this.colorVal);
  int colorVal;


  @override
  _HelpContentState createState() => _HelpContentState();
}

class _HelpContentState extends State<HelpContent>

with AutomaticKeepAliveClientMixin<HelpContent> {




  @override
  bool get wantKeepAlive => true;

  var service = CoronaService.instance;
  Future<CoronaTotalCount> _totalCountFuture;
  Future<List<CoronaCaseCountry>> _allCasesFuture;

  @override
  void initState() {
    _fetchData();
    super.initState();
  }

  _fetchData() {
    _totalCountFuture = service.fetchAllTotalCount();
    _allCasesFuture = service.fetchCases();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
        body: Center(
            child: Container(
                constraints: BoxConstraints(maxWidth: 768),
                child: SingleChildScrollView(
                  physics: AlwaysScrollableScrollPhysics(),
                  child: Column(
                    children: <Widget>[
                      _buildTotalCountWidget(context),
                      Padding(
                        padding: EdgeInsets.only(left: 16, right: 16),
                        child: Divider(),
                      ),
                      _buildAllCasesWidget(context)
                    ],
                  ),
                ))));
  }

  Widget _buildTotalCountWidget(BuildContext context) {
    return FutureBuilder(
        future: _totalCountFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Padding(
              padding: EdgeInsets.only(top: 16, bottom: 16),
              child: Center(child: CircularProgressIndicator()),
            );
          } else if (snapshot.error != null) {
            return Padding(
                padding: EdgeInsets.only(top: 16, bottom: 16),
                child: Center(
                  child: Text('Error fetching total count data'),
                ));
          } else {
            final CoronaTotalCount totalCount = snapshot.data;

            final data = [
              LinearCases(CaseType.sick.index, totalCount.sick,
                  totalCount.sickRate.toInt(), "Sick"),
              LinearCases(CaseType.deaths.index, totalCount.deaths,
                  totalCount.fatalityRate.toInt(), "Deaths"),
              LinearCases(CaseType.recovered.index, totalCount.recovered,
                  totalCount.recoveryRate.toInt(), "Recovered")
            ];

            final series = [
              charts.Series<LinearCases, int>(
                id: 'Total Count',
                domainFn: (LinearCases cases, _) => cases.type,
                measureFn: (LinearCases cases, _) => cases.total,
                labelAccessorFn: (LinearCases cases, _) =>
                    '${cases.text}\n${Utils.numberFormatter.format(cases.count)}',
                colorFn: (cases, index) {
                  switch (cases.text) {
                    case "Confirmed":
                      return charts.ColorUtil.fromDartColor(Colors.blue);
                    case "Sick":
                      return charts.ColorUtil.fromDartColor(
                          Colors.orangeAccent);
                    case "Recovered":
                      return charts.ColorUtil.fromDartColor(Colors.green);
                    default:
                      return charts.ColorUtil.fromDartColor(Colors.red);
                  }
                },
                data: data,
              )
            ];

            return Padding(
                padding:
                    EdgeInsets.only(top: 16, left: 16, right: 16, bottom: 8),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                          "Last updated: ${Utils.dateFormatter.format(DateTime.now())}"),
                      Padding(
                        padding: EdgeInsets.only(bottom: 8),
                      ),
                      Text(
                        "Global Total Cases Stats",
                        style: Theme.of(context).textTheme.headline,
                      ),
                      Container(
                          height: 200,
                          child: charts.PieChart(
                            series,
                            animate: true,
                            defaultRenderer: charts.ArcRendererConfig(
                                arcWidth: 60,
                                arcRendererDecorators: [
                                  charts.ArcLabelDecorator()
                                ]),
                          )),
                      Padding(
                        padding: EdgeInsets.only(top: 16, bottom: 8),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  Text(
                                    totalCount.confirmedText,
                                    style: Theme.of(context)
                                        .textTheme
                                        .headline
                                        .apply(color: Colors.blue),
                                  ),
                                  Text("Confirmed")
                                ],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  Text(
                                    totalCount.sickText,
                                    style: Theme.of(context)
                                        .textTheme
                                        .headline
                                        .apply(color: Colors.orange),
                                  ),
                                  Text("Sick")
                                ],
                              )
                            ]),
                      ),
                      Padding(
                          padding: EdgeInsets.only(top: 8, bottom: 8),
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: <Widget>[
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: <Widget>[
                                    Text(
                                      totalCount.recoveredText,
                                      style: Theme.of(context)
                                          .textTheme
                                          .headline
                                          .apply(color: Colors.green),
                                    ),
                                    Text("Recovered")
                                  ],
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: <Widget>[
                                    Text(
                                      totalCount.recoveryRateText,
                                      style: Theme.of(context)
                                          .textTheme
                                          .headline
                                          .apply(color: Colors.green),
                                    ),
                                    Text("Recovery Rate")
                                  ],
                                )
                              ])),
                      Padding(
                          padding: EdgeInsets.only(top: 8, bottom: 16),
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: <Widget>[
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: <Widget>[
                                    Text(
                                      totalCount.deathsText,
                                      style: Theme.of(context)
                                          .textTheme
                                          .headline
                                          .apply(color: Colors.red),
                                    ),
                                    Text("Deaths")
                                  ],
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: <Widget>[
                                    Text(
                                      totalCount.fatalityRateText,
                                      style: Theme.of(context)
                                          .textTheme
                                          .headline
                                          .apply(color: Colors.red),
                                    ),
                                    Text("Fatality Rate")
                                  ],
                                )
                              ])),
                    ]));
          }
        });
  }

  Widget _buildAllCasesWidget(BuildContext context) {
    return FutureBuilder(
      future: _allCasesFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Padding(
            padding: EdgeInsets.only(top: 16, bottom: 16),
            child: Center(child: CircularProgressIndicator()),
          );
        } else if (snapshot.error != null) {
          return Padding(
              padding: EdgeInsets.only(top: 16, bottom: 16),
              child: Center(
                child: Text('Error fetching total cases global data'),
              ));
        } else {
          if (snapshot.data == null || snapshot.data.length == 0) {
            return Padding(
              padding: EdgeInsets.only(top: 16, bottom: 16),
              child: Center(child: Text("No Data")),
            );
          }

          final List<CoronaCaseCountry> cases = snapshot.data;
          var children = List<Widget>();

          final chinaCase = cases.firstWhere(
              (element) => element.country.toLowerCase().contains('india'));

          if (chinaCase != null) {
            final data = [
              OrdinalCases("Confirmed", chinaCase.totalConfirmedCount,
                  chinaCase.coronaTotalCount),
              OrdinalCases("Recovered", chinaCase.totalRecoveredCount,
                  chinaCase.coronaTotalCount),
              OrdinalCases("Deaths", chinaCase.totalDeathsCount,
                  chinaCase.coronaTotalCount),
            ];

            final seriesList = [
              charts.Series<OrdinalCases, String>(
                id: 'China Cases',
                domainFn: (OrdinalCases cases, _) => cases.country,
                measureFn: (OrdinalCases cases, _) => cases.total,
                data: data,
                labelAccessorFn: (OrdinalCases cases, _) {
                  return '${Utils.numberFormatter.format(cases.total)}';
                },
                colorFn: (cases, index) {
                  switch (cases.country) {
                    case 'Confirmed':
                      return charts.ColorUtil.fromDartColor(Colors.blue);
                    case 'Recovered':
                      return charts.ColorUtil.fromDartColor(Colors.green);
                    default:
                      return charts.ColorUtil.fromDartColor(Colors.red);
                  }
                },
              )
            ];

            children.addAll([
              Padding(
                padding: EdgeInsets.only(top: 8),
              ),
              Text(
                "Cases in India",
                style: Theme.of(context).textTheme.headline,
              ),
              Container(
                  height: 120,
                  child: charts.BarChart(
                    seriesList,
                    animate: true,
                    barRendererDecorator:
                        new charts.BarLabelDecorator<String>(),
                    domainAxis: new charts.OrdinalAxisSpec(),
                  )),
              Padding(
                padding: EdgeInsets.only(bottom: 16),
              ),
              Divider(),
            ]);
          }

          cases.removeWhere(
              (element) => element.country.toLowerCase().contains('india'));

          var confirmedCasesData = List<OrdinalCases>();
          var deathsCasesData = List<OrdinalCases>();
          var recoveredCasesData = List<OrdinalCases>();

          cases.forEach((element) {
            final totalCount = element.coronaTotalCount;
            var tailTexts = List<String>();

            if (totalCount.deaths > 0) {
              tailTexts.add("D:${totalCount.deathsText}");
            }

            if (totalCount.recovered > 0) {
              tailTexts.add("R:${totalCount.recoveredText}");
            }

            final tailText = tailTexts.join(" - ");

            var country = element.country;
            if (tailText.isNotEmpty) {
              country += "\n" + tailText;
            }

            confirmedCasesData.add(OrdinalCases(
                country, element.totalSickCount, element.coronaTotalCount));
            deathsCasesData.add(
              OrdinalCases(
                  country, element.totalDeathsCount, element.coronaTotalCount),
            );
            recoveredCasesData.add(OrdinalCases(country,
                element.totalRecoveredCount, element.coronaTotalCount));
          });

          final int height =
              cases.fold(0, (previousValue, element) => previousValue + 40);

          var seriesList = [
            charts.Series<OrdinalCases, String>(
              id: 'Deaths',
              domainFn: (OrdinalCases cases, _) => cases.country,
              measureFn: (OrdinalCases cases, _) => cases.total,
              data: deathsCasesData,
              labelAccessorFn: (OrdinalCases cases, _) {
                return null;
              },
              colorFn: (datum, index) =>
                  charts.ColorUtil.fromDartColor(Colors.red),
            ),
            charts.Series<OrdinalCases, String>(
              id: 'Recovered',
              domainFn: (OrdinalCases cases, _) => cases.country,
              measureFn: (OrdinalCases cases, _) => cases.total,
              data: recoveredCasesData,
              labelAccessorFn: (OrdinalCases cases, _) {
                return null;
              },
              colorFn: (datum, index) =>
                  charts.ColorUtil.fromDartColor(Colors.green),
            ),
            charts.Series<OrdinalCases, String>(
              id: 'Sick',
              domainFn: (OrdinalCases cases, _) => cases.country,
              measureFn: (OrdinalCases cases, _) => cases.total,
              data: confirmedCasesData,
              colorFn: (datum, index) =>
                  charts.ColorUtil.fromDartColor(Colors.blue),
              labelAccessorFn: (OrdinalCases cases, _) {
                return '${cases.totalCount.confirmedText}';
              },
            ),
          ];

          children.addAll([
            Padding(
              padding: EdgeInsets.only(top: 16),
            ),
            Text(
              "Cases outside India",
              style: Theme.of(context).textTheme.headline,
            ),
            Container(
                height: height.toDouble(),
                child: charts.BarChart(
                  seriesList,
                  animate: true,
                  barGroupingType: charts.BarGroupingType.stacked,
                  vertical: false,
                  barRendererDecorator: charts.BarLabelDecorator<String>(),
                ))
          ]);

          return Padding(
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: children,
              ));
        }
      },
    );
  }
}

enum CaseType { confirmed, deaths, recovered, sick }

class LinearCases {
  final int type;
  final int count;
  final int total;
  final String text;

  LinearCases(this.type, this.count, this.total, this.text);
}

class OrdinalCases {
  final String country;
  final int total;
  final CoronaTotalCount totalCount;

  OrdinalCases(this.country, this.total, this.totalCount);
}





//            final FirebaseFirestore _fireStore = FirebaseFirestore.instance;

  
// void Qqq(){



//   AsyncSnapshot<dynamic> snapshot;
//  // Firebase.initializeApp();
//  // _fireStore.collection("MyContacts").snapshots();
//     List<Widget> Aaa=makeListWiget(snapshot);
//  List list1 = [24, 'Hello', 84];
// List list2 = [11, 'Hi', '5C:E0:C5:8F:0A:DD'];
// //5C:E0:C5:8F:0A:DD, 5C:E0:C5:8F:0A:DD, C9:79:C2:5D:F8:CD,
// list1.forEach((list3) { list2.forEach((list4){

// if (Aaa==list4){
// print("trueeeeeeeee");
// }
// else{
//   print("falseeeeeee");
// }

// });



// });



// }


//  @override
//   void initState() {
//     super.initState();

   


//     WidgetsFlutterBinding.ensureInitialized();
//    //Firebase.initializeApp();
//  Timer.periodic(Duration(seconds: 18), (Timer t) => Qqq());
//   }


  


//  String contact_traced, studentID, studyProgramID;
//   double studentGPA;
//  String _data = '';
//   getStudentName(chetan) {
//     this.contact_traced = "chetan";
//   }

//   getStudentID(_data) {
//     this.studentID = _data;
//   }

//   getStudyProgramID(programID) {
//     this.studyProgramID = programID;
//   }

//   getStudentGPA(gpa) {
//     this.studentGPA = double.parse(gpa);
//   }
// Map data;
// fetchData(){
//   CollectionReference collectionReference = Firestore.instance.collection('MyContacts');
//   collectionReference.snapshots().listen((snapshot) {
// setState(() {
//   data;
// }); 
//   });
// }
// //  readData() {
// //     DocumentReference documentReference =
// //         Firestore.instance.collection("MyStudents").document(contact_traced);

// //     documentReference.get().then((datasnapshot) {
// //       print(datasnapshot.data["studentName"]);
// //       print(datasnapshot.data["studentID"]);
// //       print(datasnapshot.data["studyProgramID"]);
// //       print(datasnapshot.data["studentGPA"]);
// //     });
// //   } 



// // @override
// //    Widget build(BuildContext context) {
// // return new Scaffold(
// // appBar: new AppBar(
// //   title: new Text('Firestore')
// // ),
// // body:  StreamBuilder(
// //   stream: FirebaseFirestore.instance.collection('MyContacts').snapshots(),
// //   builder: (context, snapshot){
// //  if(!snapshot.hasData) return Text('Loading Data...');
// //  return Column(
// //    children: <Widget>[
// //     // Text(snapshot.data.document.get('User')),
// //    ],
// //  );
// //   },
// //   ),
// // );

// //    }



//      @override
//       Widget build(BuildContext context) {
//         return FutureBuilder(
// //future: Firebase.initializeApp(),
//           builder: (context, snapshot) {
//           //  final FirebaseFirestore _fireStore = FirebaseFirestore.instance;
//             return Scaffold(
//                 appBar: AppBar(
//                   title: Text('Área do Cliente'),
//                 ),
//                 body: Container(
//                     child: StreamBuilder(
//                         // stream: _fireStore
//                         //     .collection("MyContacts")
//                         //     .snapshots(),
//                         builder: (context, snapshot) {
//                           return ListView(
//                             children: makeListWiget(snapshot),
//                           );
//                         })));
//           },

          
//         );

//          RaisedButton(
//                   color: Colors.blue,
//                   shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(16)),
//                   child: Text("Read"),
//                   textColor: Colors.white,
//                   onPressed: () {
//                     Qqq();
//                   },
//                 );
//       }




//      List<Widget> makeListWiget(AsyncSnapshot snapshot) {
//     return snapshot.data.documents.map<Widget>((document) {
//       return ListTile(
//        title: Text(document.get('contact_traced')),
//         //subtitle: Text(document.get('studentName')),
//       );
//     }).toList();
//   }

//   // @override
//   // Widget build(BuildContext context) {
//   //   getStudentName("chetan");
//   //    getStudentID(_data);
//   //   return Scaffold(
//   //     appBar: AppBar(
//   //       title: Text("My Flutter College"),
//   //     ),
//   //     body: Padding(
//   //       padding: EdgeInsets.all(16.0),
//   //       child: Column(
//   //         children: <Widget>[
//   //           Expanded(child: Text(_data)),
            
// //             Padding(
// //               padding: EdgeInsets.only(bottom: 8.0),
// //               child: TextFormField(
// //                 decoration: InputDecoration(
// //                     labelText: "Name",
// //                     fillColor: Colors.white,
// //                     focusedBorder: OutlineInputBorder(
// //                         borderSide:
// //                             BorderSide(color: Colors.blue, width: 2.0))),
                
// //               ),
// //             ),
// //             Padding(
// //               padding: EdgeInsets.only(bottom: 8.0),
// //               child: TextFormField(
// //                 decoration: InputDecoration(
// //                     labelText: "Student ID",
// //                     fillColor: Colors.white,
// //                     focusedBorder: OutlineInputBorder(
// //                         borderSide:
// //                             BorderSide(color: Colors.blue, width: 2.0))),
               
// //               ),
// //             ),
// //             Padding(
// //               padding: EdgeInsets.only(bottom: 8.0),
// //               child: TextFormField(
// //                 decoration: InputDecoration(
// //                     labelText: "Study Program ID",
// //                     fillColor: Colors.white,
// //                     focusedBorder: OutlineInputBorder(
// //                         borderSide:
// //                             BorderSide(color: Colors.blue, width: 2.0))),
               
// //               ),
// //             ),
// //             Padding(
// //               padding: EdgeInsets.only(bottom: 8.0),
// //               child: TextFormField(
// //                 decoration: InputDecoration(
// //                     labelText: "GPA",
// //                     fillColor: Colors.white,
// //                     focusedBorder: OutlineInputBorder(
// //                         borderSide:
// //                             BorderSide(color: Colors.blue, width: 2.0))),
                
// //               ),
// //             ),
// //             Row(
// //               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
// //               children: <Widget>[
// //                 RaisedButton(
// //                   color: Colors.green,
// //                   shape: RoundedRectangleBorder(
// //                       borderRadius: BorderRadius.circular(16)),
// //                   child: Text("Create"),
// //                   textColor: Colors.white,
// //                   onPressed: () {
// //                     createData();
// //                   },
// //                 ),
//                 // RaisedButton(
//                 //   color: Colors.blue,
//                 //   shape: RoundedRectangleBorder(
//                 //       borderRadius: BorderRadius.circular(16)),
//                 //   child: Text("Read"),
//                 //   textColor: Colors.white,
//                 //   onPressed: () {
//                 //     Qqq();
//                 //   },
//                 // ),
// //                 RaisedButton(
// //                   color: Colors.orange,
// //                   shape: RoundedRectangleBorder(
// //                       borderRadius: BorderRadius.circular(16)),
// //                   child: Text("Update"),
// //                   textColor: Colors.white,
// //                   onPressed: () {
// //                     updateData();
// //                   },
// //                 ),
// //                 RaisedButton(
// //                   color: Colors.red,
// //                   shape: RoundedRectangleBorder(
// //                       borderRadius: BorderRadius.circular(16)),
// //                   child: Text("Delete"),
// //                   textColor: Colors.white,
// //                   onPressed: () {
// //                     deleteData();
// //                   },
// //                 )
// //               ],
// //             ),


// //  Center(
// //                 child: RaisedButton(
// //                     // padding: EdgeInsets.only(bottom: 20.0, right: 10.0),
// //                     color: Color.alphaBlend(Colors.green, Colors.green),
// //                     shape: RoundedRectangleBorder(
// //                       borderRadius: BorderRadius.circular(30.0),
// //                       //side: BorderSide(color: Colors.red)
// //                     ),
// //                     child: Text(_scanning ? 'scan' : 'scan',
// //                         style: TextStyle(
// //                           fontFamily: 'Avenir',
// //                           fontWeight: FontWeight.bold,
// //                           fontSize: 15.0,
// //                         )),
// //                     onPressed: Qqq,
                                        
                                          
                    
                                          
// //                                        // }
// //                                         ),
// //                                   ),

// //             Padding(
// //               padding: EdgeInsets.all(8.0),
// //               child: Row(
// //                 textDirection: TextDirection.ltr,
// //                 children: <Widget>[
// //                   Expanded(
// //                     child: Text("Name"),
// //                   ),
// //                   Expanded(
// //                     child: Text("Student ID"),
// //                   ),
// //                   Expanded(
// //                     child: Text("Program ID"),
// //                   ),
// //                   Expanded(
// //                     child: Text("GPA"),
// //                   )
// //                 ],
// //               ),
// //             ),
// //             StreamBuilder(
// //               stream: Firestore.instance.collection("MyStudents").snapshots(),
// //               builder: (context, snapshot) {
// //                 if (snapshot.hasData) {
// //                   return ListView.builder(
// //                       shrinkWrap: true,
// //                       itemCount: snapshot.data.documents.length,
// //                       itemBuilder: (context, index) {
// //                         DocumentSnapshot documentSnapshot =
// //                             snapshot.data.documents[index];
// //                         // return Row(
// //                         //   children: <Widget>[
// //                         //     Expanded(
// //                         //       child: Text(documentSnapshot["studentName"]),
// //                         //     ),
// //                         //     Expanded(
// //                         //       child: Text(documentSnapshot["studentID"]),
// //                         //     ),
// //                         //     Expanded(
// //                         //       child: Text(documentSnapshot["studyProgramID"]),
// //                         //     ),
// //                         //     Expanded(
// //                         //       child: Text(
// //                         //           documentSnapshot["studentGPA"].toString()),
// //                         //     )
// //                         //   ],
// //                         // );
// //                       });
// //                 } else {
// //                   return Align(
// //                     alignment: FractionalOffset.bottomCenter,
// //                     child: CircularProgressIndicator(),
// //                   );
// //                 }
// //               },
// //             )
//   //         ],
//   //       ),
//   //     ),
//   //   );
//   // }















//   // @override
//   // Widget build(BuildContext context) {
   
//   //   return new MaterialApp(
//   //     home: new Scaffold(
//   //       appBar: new AppBar(
//   //         title: const Text('Contact Tracing (Build1)'),
//   //         backgroundColor: Color.alphaBlend(Colors.green, Colors.green),
//   //       ),
//   //       body: Column(
//   //         mainAxisAlignment: MainAxisAlignment.start,
//   //         children: <Widget>[
//   //           Padding(padding: const EdgeInsets.only(top: 30.0)),
//   //           Expanded(child: Text(_data)),
            
//   //           Padding(
              
//   //             padding: const EdgeInsets.all(10.0),
//   //             child: Center(
//   //               child: RaisedButton(
//   //                   // padding: EdgeInsets.only(bottom: 20.0, right: 10.0),
//   //                   color: Color.alphaBlend(Colors.green, Colors.green),
//   //                   shape: RoundedRectangleBorder(
//   //                     borderRadius: BorderRadius.circular(30.0),
//   //                     //side: BorderSide(color: Colors.red)
//   //                   ),
//   //                   child: Text(_scanning ? 'scan' : 'scan',
//   //                       style: TextStyle(
//   //                         fontFamily: 'Avenir',
//   //                         fontWeight: FontWeight.bold,
//   //                         fontSize: 15.0,
//   //                       )),
//   //                   onPressed: Aaaa,
                                        
                                          
                    
                                          
//   //                                      // }
//   //                                       ),
//   //                                 ),
//   //                               )
//   //                             ],
//   //                           ),
//   //                         ),
//   //                       );
//   //                     }
                    
                    
                    
                    
                    
                    
                    
                    
                      
                    

//}
