import 'package:flutter/material.dart';
import './questions.dart';
import './answers.dart';
import './tree.dart';
import './result.dart';

class SelfAssessContent extends StatefulWidget {
  SelfAssessContent(this.colorVal);
  int colorVal;
  @override
  _SelfAssessContentState createState() => _SelfAssessContentState();
}

class _SelfAssessContentState extends State<SelfAssessContent> {
  var _questions = [
    {
      'questionKey':
          'Within the last 14-days, have you experienced a new cough that you cannot attribute to another health condition?',
      'answerKey': [
        {'text': 'Yes', 'score': 5},
        {'text': 'No', 'score': 0},
      ],
    },
    {
      'questionKey':
          'Within the last 14-days, have you experienced new shortness of breath that you cannot attribute to another health condition? ',
      'answerKey': [
        {'text': 'Yes', 'score': 5},
        {'text': 'No', 'score': 0}
      ],
    },
    {
      'questionKey':
          'Within the last 14-days, have you experienced sore throat that you cannot attribute to another health condition?',
      'answerKey': [
        {'text': 'Yes', 'score': 5},
        {'text': 'No', 'score': 0}
      ],
    },
    {
      'questionKey':
          'Within the last 14-days, have you experienced muscle aches that you cannot attribute to another health condition.?',
      'answerKey': [
        {'text': 'Yes', 'score': 5},
        {'text': 'No', 'score': 0}
      ],
    },
    {
      'questionKey':
          'Within the last 14-days, have you had a temperature at or above 100.4° or the sense of having a fever?',
      'answerKey': [
        {'text': 'Yes', 'score': 5},
        {'text': 'No', 'score': 0}
      ],
    },
    {
      'questionKey':
          'Within the last 14 days, have you had close contact, with someone who is currently sick with suspected or confirmed COVID-19?',
      'answerKey': [
        {'text': 'Yes', 'score': 5},
        {'text': 'No', 'score': 0}
      ],
    },
    {
      'questionKey':
          'Experienced following symptoms?\n• Shortness of breath or difficulty breathing\n• Chills\n• New loss of taste or smell ',
      'answerKey': [
        {'text': 'Yes', 'score': 8},
        {'text': 'No', 'score': 0}
      ],
    },
    {
      'questionKey':
          'Have you been tested for the virus that causes COVID-19 with a positive or pending result in the last 14 days?',
      'answerKey': [
        {'text': 'Yes', 'score': 5},
        {'text': 'No', 'score': 0}
      ],
    },
    {
      'questionKey':
          'In the past 14 days, have you had close contact (within 6 feet for 15 or more min) with suspected or confirmed COVID-19 person?',
      'answerKey': [
        {'text': 'Yes', 'score': 5},
        {'text': 'No', 'score': 0}
      ],
    },
    {
      'questionKey':
          'Did you travel via public transportation (air, train, bus)?',
      'answerKey': [
        {'text': 'Yes', 'score': 5},
        {'text': 'No', 'score': 0}
      ],
    },
    {
      'questionKey': 'What building or spaces are you intending to visit?',
      'answerKey': [
        {'text': 'contaminated', 'score': 8},
        {'text': 'Non contaminated', 'score': 0}
      ],
    },
  ];

  var _questionIndex = 0;
  var _totalScore = 0;

  void _resetQuiz() {
    setState(() {
      _questionIndex = 0;
      _totalScore = 0;
    });
  }

  void _answerYes(int score) {
    _totalScore = _totalScore + score;
    setState(() {
      _questionIndex = _questionIndex + 1;
    });

    if (_questionIndex < _questions.length) {
      print('We have more questions');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _questionIndex < _questions.length
          ? Tree(
              answerQuestion: _answerYes,
              questionIndex: _questionIndex,
              questions: _questions)
          : Result(_totalScore, _resetQuiz),
    );
  }
}
