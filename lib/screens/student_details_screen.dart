import 'package:flutter/material.dart';

class StudentDetailsScreen extends StatelessWidget {
  const StudentDetailsScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Hero(
                tag:'studentdetails',
                  child: Container(
            height: 200,
            width: 200,
            alignment: Alignment.topCenter,
            decoration: BoxDecoration(
            shape: BoxShape.circle,
            image: DecorationImage(
                fit: BoxFit.contain,
                image: AssetImage('assets/images/girl.jpg'))),
    ),
        ));
  }
}
