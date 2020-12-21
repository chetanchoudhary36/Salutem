import 'package:flutter/material.dart';

class Answer extends StatelessWidget {
  final Function selectAnswer;
  final String answerKey;

  Answer(this.selectAnswer, this.answerKey);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: SingleChildScrollView(
        child: RaisedButton(
          color: Colors.blue,
          textColor: Colors.black,
          child: Text(answerKey),
          onPressed: selectAnswer,
        ),
      ),
    );
  }
}
