import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:parent_app/components/digicampus_appbar.dart';
import 'package:parent_app/components/digi_key_value_display.dart';
import 'package:parent_app/models/student.dart';

class StudentDetailsScreen extends StatefulWidget {
  const StudentDetailsScreen({
    Key key,
  }) : super(key: key);

  @override
  _StudentDetailsScreenState createState() => _StudentDetailsScreenState();
}

class _StudentDetailsScreenState extends State<StudentDetailsScreen> {
  bool isFading = false;
  PageController _pageController = PageController(viewportFraction: 0.65);
  final List<Student> _students = [
    Student()
        .fromMap('{"id":1001,"name":"Karthyaaayini","parentName":"Ajith"}'),
    Student().fromMap('{"id":1002,"name":"Arjunan","parentName":"Ajith"}'),
    Student().fromMap('{"id":1003,"name":"Ajith","parentName":"Ajith"}')
  ];
  Student selectedStudent = Student()
      .fromMap('{"id":1001,"name":"Karthyaayini","parentName":"Ajith"}');
  @override
  void initState() {
    //selectedStudent=_students.first;
    _pageController.addListener(() {
      int page = _pageController.page.truncate();
      print(page);
      print(_pageController.page.toStringAsFixed(1));
      if (_pageController.page.toStringAsFixed(1).startsWith(RegExp(r'^[0-9].5$'))) {
        setState(() {
          isFading = true;
        });
      } else if (_pageController.page.toStringAsFixed(1).startsWith(RegExp(r'^[0-9].0$'))) {
        setState(() {
          isFading = false;
          selectedStudent = _students.elementAt(page);
        });
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    //String displayParentId = parentId.toString();
    String displayStudentId = selectedStudent.id.toString();
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
                AnimatedOpacity(
                  opacity: isFading ? 0 : 1,
                  duration: Duration(milliseconds: isFading ? 400 : 100),
                  child: AnimatedContainer(
                      //color: Colors.blue,
                      height: isFading ? 4 : 25,
                      width: isFading ? 4 : 200,
                      alignment: Alignment.center,
                      duration: Duration(milliseconds: isFading ? 400 : 100),
                      child: Text(
                        selectedStudent.name,
                        style: TextStyle(
                          decoration: TextDecoration.none,
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                          //backgroundColor: Colors.blue[800],
                          fontSize: 22,
                        ),
                      )),
                ),
                SizedBox(height: 6),
                Container(
                  height: 150,
                  child: PageView.builder(
                      controller: _pageController,
                      itemCount: _students.length,
                      itemBuilder: (context, index) {
                        return Hero(
                          tag: _students.elementAt(index).id.toString(),
                          child: Center(
                            child: Container(
                              child: ClipOval(
                                  child: Image.asset(
                                      'assets/images/${_students.elementAt(index).id.toString()}.jpg',
                                      fit: BoxFit.fill)),
                              height: 150,
                              width: 150,
                            ),
                          ),
                        );
                      }),
                  // PageView(
                  //   controller: _pageController,
                  //   children: <Widget>[
                  //     Hero(
                  //       tag: 'studentdetails',
                  //       child: Center(
                  //         child: Container(
                  //           child: ClipOval(
                  //               child: Image.asset('assets/images/girl.jpg',
                  //                   fit: BoxFit.fill)),
                  //           height: 150,
                  //           width: 150,
                  //         ),
                  //       ),
                  //     ),
                  //     Hero(
                  //       tag: 'student2',
                  //       child: Center(
                  //         child: Container(
                  //           child: ClipOval(
                  //               child: Image.asset(
                  //             'assets/images/boy.jpg',
                  //             fit: BoxFit.fill,
                  //           )),
                  //           height: 150,
                  //           width: 150,
                  //         ),
                  //       ),
                  //     ),
                  //   ],
                  // ),
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
                            textKey: 'Student Name',
                            textValue: '<Name>',
                            textColor: Colors.white),
                        DigiKeyValueDisplay(
                            textKey: 'Parent Name',
                            textValue: '<P_Name>',
                            textColor: Colors.white),
                        DigiKeyValueDisplay(
                            textKey: 'Class Teacher',
                            textValue: '<T_Name>',
                            textColor: Colors.white),
                        DigiKeyValueDisplay(
                            textKey: 'Class',
                            textValue: '<CLASS>',
                            textColor: Colors.white),
                        DigiKeyValueDisplay(
                            textKey: 'Date of Birth',
                            textValue: '<D-O-B>',
                            textColor: Colors.white),
                        DigiKeyValueDisplay(
                            textKey: 'Age',
                            textValue: '<Age>',
                            textColor: Colors.white),
                        DigiKeyValueDisplay(
                            textKey: 'Blood Group',
                            textValue: '<Type>',
                            textColor: Colors.white),
                        DigiKeyValueDisplay(
                            textKey: 'Rewards',
                            textValue: '<**@*@*@**>',
                            textColor: Colors.white),

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
        _students.length > 1
            ? Container(
                height: 395,
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: Container(
                        alignment: Alignment.centerLeft,
                        child: GestureDetector(
                          behavior: HitTestBehavior.translucent,
                          child: Icon(CupertinoIcons.left_chevron,
                              size: 30, color: Colors.white.withOpacity(0.9)),
                          onTap: () async {
                            print(_pageController.offset);
                            // _pageController.animateTo(
                            //     _pageController.offset - 0.5,
                            //     duration: Duration(milliseconds: 100),
                            //     curve: Curves.linear);
                            // await Future.delayed(Duration(milliseconds: 400));
                            _pageController.previousPage(
                                duration: Duration(milliseconds: 500),
                                curve: Curves.linear);
                          },
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        alignment: Alignment.centerRight,
                        child: GestureDetector(
                          behavior: HitTestBehavior.translucent,
                          child: Icon(CupertinoIcons.right_chevron,
                              size: 30, color: Colors.white.withOpacity(0.9)),
                          onTap: () {
                            _pageController.nextPage(
                                duration: Duration(milliseconds: 500),
                                curve: Curves.linear);
                          },
                        ),
                      ),
                    )
                  ],
                ),
              )
            : Container()
      ],
    ));
  }
}
