import 'package:flutter/material.dart';

import 'bottom_sheet_text.dart';

class Gcontact extends StatelessWidget {
  Gcontact(
      {this.imagePath,
      this.email,
      this.infection,
      this.contactUsername,
      this.contactTime,
      this.contactLocation});

  final String imagePath;
  final String email;
  final String infection;
  final String contactUsername;
  final DateTime contactTime;
  final String contactLocation;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3.0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
      child: ListTile(
        leading: CircleAvatar(
          backgroundImage: AssetImage(imagePath),
        ),
        trailing: Icon(Icons.more_horiz),
        title: Text(
          email,
          style: TextStyle(
            color: Colors.deepPurple[700],
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Text(infection),
        onTap: () => showModalBottomSheet(
            context: context,
            builder: (builder) {
              return Padding(
                padding: EdgeInsets.symmetric(vertical: 50.0, horizontal: 10.0),
                child: Column(
                  children: <Widget>[
                    BottomSheetText(
                        question: 'Company', result: contactUsername),
                    SizedBox(height: 5.0),
                    BottomSheetText(
                        question: 'Scheduled Date',
                        result: contactTime.toString()),
                    SizedBox(height: 5.0),
                    BottomSheetText(
                        question: 'Scheduled Room', result: contactLocation),
                    SizedBox(height: 5.0),
                    BottomSheetText(question: 'In Contract', result: 'Yes'),
                  ],
                ),
              );
            }),
      ),
    );
  }
}
