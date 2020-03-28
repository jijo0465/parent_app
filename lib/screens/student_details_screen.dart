import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:parent_app/components/digicampus_appbar.dart';
import 'package:parent_app/components/digi_key_value_display.dart';

class StudentDetailsScreen extends StatelessWidget {
  final String studentName;
  final int studentId;
  const StudentDetailsScreen({
    Key key,
    this.studentName = 'Arjun Ajith',
    this.studentId = 1125,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //String displayParentId = parentId.toString();
    String displayStudentId = studentId.toString();
    displayStudentId = 'S-' + displayStudentId;
    return Scaffold(
        body: Stack(
      children: <Widget>[
        Container(
          padding: EdgeInsets.only(top: 35),
          height: 400,
          width: double.infinity,
          child: Image.asset(
            'assets/images/school.jpg',
            fit: BoxFit.fill,
          ),
        ),
        BackdropFilter(
          filter: ImageFilter.blur(sigmaY: 4, sigmaX: 4),
          child: Container(
            color: Colors.black.withOpacity(0.3),
            child: Column(
              children: <Widget>[
                DigiCampusAppbar(
                  icon: Icons.home,
                  onDrawerTapped: () {
                    Navigator.of(context).pop();
                  },
                ),
                SizedBox(height: 6),
                Container(
                    alignment: Alignment.center,
                    child: Text(
                      ' $studentName',
                      style: TextStyle(
                        decoration: TextDecoration.none,
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                        //backgroundColor: Colors.blue[800],
                        fontSize: 22,
                      ),
                    )),
                SizedBox(height: 6),
                Hero(
                  tag: 'studentdetails',
                  child: Container(
                    height: 150,
                    width: 150,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                            alignment: Alignment.center,
                            fit: BoxFit.fill,
                            image: AssetImage('assets/images/girl.jpg'))),
                  ),
                ),
                SizedBox(height: 12),
                Expanded(
                  child: Container(
                    //color: Colors.blue[800],
                    //alignment: Alignment.center,
                    //width:MediaQuery.of(context).size.width,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        SizedBox(height: 6),
                        Container(
                          child: Text(
                            'Student ID : $displayStudentId',
                            style: TextStyle(fontSize: 16, color: Colors.white),
                          ),
                        ),
                        SizedBox(height: 6),
                        DigiKeyValueDisplay(
                            textKey: 'Student Name', textValue: '<Name>', textColor: Colors.white),
                        DigiKeyValueDisplay(
                            textKey: 'Parent Name', textValue: '<P_Name>', textColor: Colors.white),
                        DigiKeyValueDisplay(
                            textKey: 'Class Teacher', textValue: '<T_Name>', textColor: Colors.white),
                        DigiKeyValueDisplay(
                            textKey: 'Class', textValue: '<CLASS>', textColor: Colors.white),
                        DigiKeyValueDisplay(
                            textKey: 'Date of Birth', textValue: '<D-O-B>', textColor: Colors.white),
                        DigiKeyValueDisplay(textKey: 'Age', textValue: '<Age>', textColor: Colors.white),
                        DigiKeyValueDisplay(
                            textKey: 'Blood Group', textValue: '<Type>', textColor: Colors.white),
                        DigiKeyValueDisplay(
                            textKey: 'Rewards', textValue: '<**@*@*@**>', textColor: Colors.white),

                        // DigiKeyValueDisplay(),
                        // DigiKeyValueDisplay(),
                        SizedBox(height: 6),
                      ],
                    ),
                    decoration: BoxDecoration(
                        color: Colors.blue[800],
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(50),
                            topRight: Radius.circular(50))),
                    height: 120 - MediaQuery.of(context).padding.top,
                    width: MediaQuery.of(context).size.width,
                  ),
                )
              ],
            ),
          ),
        ),
      ],
    ));
  }
}
