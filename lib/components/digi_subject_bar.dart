import 'package:flutter/material.dart';

class DigiSubjectBar extends StatelessWidget {
  final int index;
  final VoidCallback onPressed;
  bool isSelected=false;
  DigiSubjectBar({Key key, this.index, this.onPressed, this.isSelected})
      : super(key: key);

  static List<Map<String, String>> subjects = [
    {'no': '0', 'sub': 'All'},
    {'no': '1', 'sub': 'Mathematics'},
    {'no': '1', 'sub': 'English'},
    {'no': '2', 'sub': 'Social'},
    {'no': '3', 'sub': 'Science'},
    {'no': '4', 'sub': 'Malayalam'},
    {'no': '5', 'sub': 'Hindi'}
  ];
  static Color borderColor = Colors.red[300],
      textColor = Colors.black54,
      backgroundColor = Colors.white38,
      indexBackgroundColor = Colors.red[300];
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: onPressed,
        child: Container(
            width: 80,
            height: 80,
            margin: EdgeInsets.only(right: 5),
            decoration: BoxDecoration(
              color: (isSelected)?indexBackgroundColor:backgroundColor,
              border: Border.all(
                  color: borderColor, style: BorderStyle.solid, width: 2.0),
              shape: BoxShape.circle,
            ),
            alignment: Alignment.center,
            child: Text(
              DigiSubjectBar.subjects[index]['sub'],
              style: TextStyle(
                  color: textColor,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  fontStyle: FontStyle.italic),
              textScaleFactor: 0.60,
              textAlign: TextAlign.center,
              overflow: TextOverflow.fade,
            )));
  }
}
