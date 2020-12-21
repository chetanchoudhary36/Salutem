import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter_scan_bluetooth_example/Landing/udash.dart';
import 'package:intl/intl.dart';
final format = DateFormat("yyyy-MM-dd HH:mm");
 var currentSelectedValue;
  final deviceTypes = ["Prakat", "Intuit", "Other"];
class DateTimeForm extends StatelessWidget {


  

  // This widget is the root of your application.

  String _company = "Choose Company";
  var _companyvalue = ['intuit', 'prakat', 'Other'];
  int _selectedCompany = 0;
  List<DropdownMenuItem<int>> companyList = [];
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Code Sample for Scaffold.of.',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        body: MyScaffoldBody(),
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(70.0),
          child: AppBar(
            backgroundColor: Colors.black87,
            title: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Image.asset(
                  'lib/assets/GlanHealth-logo.png',
                  alignment: Alignment.centerLeft,
                  fit: BoxFit.contain,
                  height: 102,
                  width: 82,
                ),
                Container(
                    padding: const EdgeInsets.only(left: 38.0, top: 10),
                    child: Text(
                      'Request Sanitization',
                      style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'Avenir',
                        fontSize: 24.0,
                        fontWeight: FontWeight.w400,
                      ),
                    ))
              ],
            ),
          ),
        ),
      ),
      color: Colors.white,
    );
  }
}

class MyScaffoldBody extends StatelessWidget {

String studentName, studentID, studyProgramID;
  double studentGPA;

  getStudentName(newValue) {
    this.studentName = newValue;
  }
getStudentID(id) {
    this.studentID = id;
  }
DateTime aaaaaaaa;
createData() {
    DocumentReference documentReference =
        Firestore.instance.collection("schedule").document();

    // create Map
    Map<String, dynamic> students = {
      "company": studentName,
      "contact time": aaaaaaaa,
     // "studyProgramID": studyProgramID,
     // "studentGPA": studentGPA
    };

    documentReference.setData(students).whenComplete(() {
      print("$studentName created");
    });
  }


  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              Form(
                // key: formKey,
                child: Column(
                  children: <Widget>[
                    SizedBox(
                      height: 80,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 190),
                      child: Text(
                        "Select Company :",
                        style: TextStyle(
                          color: Colors.black87,
                          fontFamily: 'Avenir',
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    SizedBox(height: 20),

                    Padding(
      padding: EdgeInsets.symmetric(horizontal: 10),
      child: FormField<String>(
        builder: (FormFieldState<String> state) {
          return InputDecorator(
            decoration: InputDecoration(
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(25)),
              labelText: "Company",
            ),
            child: DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                hint: Text("Select Company"),
                value: currentSelectedValue,
                isDense: true,
                onChanged: (newValue) {
                 // setState(() {
                    currentSelectedValue = newValue;
                    getStudentName(newValue);
                //  });
                  print(currentSelectedValue);
                },
                items: deviceTypes.map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
            ),
          );
        },
      ),
       ),



                 //   DDM(),
                    SizedBox(height: 20),
                    SizedBox(height: 20),
                     Padding(
        padding: const EdgeInsets.only(right: 180),
        child: Text(
          'Enter Date & Time:',
          style: TextStyle(
            color: Colors.black87,
            fontFamily: 'Avenir',
            fontSize: 16.0,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      SizedBox(height: 20),
      DateTimeField(
        decoration: new InputDecoration(
          labelText: "Enter Schedule",
          fillColor: Colors.white,

          border: new OutlineInputBorder(
            borderRadius: new BorderRadius.circular(25.0),
            borderSide: new BorderSide(),
          ),
          //fillColor: Colors.green
        ),
        format: format,
        onShowPicker: (context, currentValue) async {
          final date = await showDatePicker(
              context: context,
              firstDate: DateTime(1900),
              initialDate: currentValue ?? DateTime.now(),
              lastDate: DateTime(2100));
          if (date != null) {
            final time = await showTimePicker(
              context: context,
              initialTime:
                  TimeOfDay.fromDateTime(currentValue ?? DateTime.now()),
            );
            aaaaaaaa=DateTimeField.combine(date, time);
            return DateTimeField.combine(date, time);
          } else {
            return currentValue;
          }
          
           onChanged: (String id) {
                  getStudentID(id);
                };
        },
        
      ),
                   // BasicDateTimeField(),
                    SizedBox(height: 40),

                    //onPressed: performLogin,
                    // formKey.currentState.save(),

                    RaisedGradientButton(
                        child: Text(
                          'Save',
                          style: TextStyle(
                            color: Colors.white,
                            fontFamily: 'Avenir',
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        gradient: LinearGradient(
                          colors: <Color>[Colors.pink, Colors.blue],
                        ),
                        onPressed: () {
                          createData();
                          Scaffold.of(context).showSnackBar(
                            SnackBar(
                              content: Text('Scheduling Done !'),
                            ),
                          );
                           Navigator.push(context,
                     new MaterialPageRoute(builder: (context) => new Udash()));
                        }),
                  ],
                ),
              )
            ],
          ),
        )
      ],
    ));
  }
}


//...................................................................

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
