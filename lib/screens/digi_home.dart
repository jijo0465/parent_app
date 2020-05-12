import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:parent_app/components/digi_appbar.dart';
import 'package:parent_app/components/digi_drawer.dart';
import 'package:parent_app/components/digi_menu_card.dart';
import 'package:parent_app/components/home_card.dart';
import 'package:parent_app/components/home_header.dart';
import 'package:parent_app/models/student.dart';
import 'package:parent_app/screens/login_screen.dart';
import 'package:parent_app/screens/student_details_screen.dart';
import 'package:parent_app/states/login_state.dart';
import 'package:parent_app/states/student_state.dart';
import 'package:provider/provider.dart';
import 'dart:math';

class DigiHome extends DrawerContent {
  DigiHome({Key key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

HiddenDrawerController drawerController;

class _HomeScreenState extends State<DigiHome> with TickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
    drawerController = HiddenDrawerController(
      initialPage: HomePage(
        title: 'main',
      ),
      items: [
        DrawerItem(
          text: Text('Home', style: TextStyle(color: Colors.black)),
          icon: Icon(Icons.home, color: Colors.black),
        ),
        DrawerItem(
          text: Text(
            'SETTINGS',
            style: TextStyle(color: Colors.black),
          ),
          icon: Icon(Icons.settings, color: Colors.black),
          onPressed: () async {
            await Navigator.of(context).pushNamed('/settings');
            drawerController.close();
          },
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<LoginState>(
      builder: (BuildContext context, LoginState value, Widget child) {
        if (value.status == Status.Unauthenticated) {
          return LoginScreen();
        } else {
          return Scaffold(
            body: HiddenDrawer(
              controller: drawerController,
              header: Container(
                child: Row(
                  children: <Widget>[
                    Expanded(
                      flex: 66,
                      child: Container(
                        child: Column(
                          children: <Widget>[
                            Container(
                              width: MediaQuery.of(context).size.width * 0.5,
                              height: MediaQuery.of(context).size.width * 0.5,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  fit: BoxFit.fill,
                                  image: AssetImage(
                                    'assets/images/sir.jpg',
                                  ),
                                ),
                                shape: BoxShape.circle,
                              ),
                            ),
                            SizedBox(
                              height: 6,
                            ),
                            Text(
                              'Rachel green',
                              style:
                                  TextStyle(color: Colors.black, fontSize: 20),
                            ),
                            RaisedButton(
                                child: Text('Signout'),
                                onPressed: () {
                                  value.signOut();
                                })
                          ],
                        ),
                      ),
                    ),
                    Expanded(flex: 34, child: Container())
                  ],
                ),
              ),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topRight,
                  end: Alignment.bottomLeft,
                  colors: [Colors.blue[300], Colors.blue[800], Colors.blue],
                  // tileMode: TileMode.repeated,
                ),
              ),
            ),
          );
        }
      },
    );
  }
}

class HomePage extends DrawerContent {
  const HomePage({this.title, Key key}) : super(key: key);
  final String title;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int pageNo = 0;

  double _height = 300.0;
  bool stateChanged = false;
  bool isLoading = true;
  Student selectedStudent;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    StudentState state = Provider.of<StudentState>(context, listen: true);
    state.addListener(() {
      setSelectedStudent(state.selectedstudent);
    });
    selectedStudent = state.selectedstudent;

    return Scaffold(
        bottomNavigationBar: BottomNavigationBar(items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), title: Text('Home')),
          BottomNavigationBarItem(icon: Icon(Icons.info), title: Text('About'))
        ]),
        body: isLoading
            ? Container(
                child: Center(
                  child: CupertinoActivityIndicator(),
                ),
              )
            : Container(
                child:
                    Consumer<StudentState>(builder: (context, studentState, _) {
                  selectedStudent = studentState.selectedstudent;
                  return Stack(
                    children: <Widget>[
                      Container(
                        decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                          Colors.grey[300],
                          Colors.grey[100],
                          Colors.grey[300]
                        ])),
                      ),
                      Container(
                          child: Column(children: <Widget>[
                        HomeHeader(
                          onStudentTapped: () {
                            isLoading = true;
                            Navigator.push(
                              context,
                              PageRouteBuilder(
                                transitionDuration: Duration(milliseconds: 400),
                                pageBuilder: (_, __, ___) =>
                                    StudentDetailsScreen(),
                              ),
                            ).then((value) {
                              setState(() {
                                isLoading = false;
                              });
                            });
                          },
                          height: _height,
                          onDragEnd: (_) {
                            print(_height);
                            if (_height < 600) {
                              setState(() {
                                _height = 300;
                              });
                            }
                          },
                          onDrag: (dragUpdateDetails) {
                            // print(dragUpdateDetails.globalPosition.distance);
                            // print(dragUpdateDetails.globalPosition.dy);
                            if (dragUpdateDetails.delta.dy > 0) {
                              if (dragUpdateDetails.globalPosition.distance >
                                  MediaQuery.of(context).size.height * 0.7) {
                                Navigator.push(
                                  context,
                                  PageRouteBuilder(
                                    transitionDuration:
                                        Duration(milliseconds: 400),
                                    pageBuilder: (_, __, ___) =>
                                        StudentDetailsScreen(),
                                  ),
                                ).then((value) {
                                  // setState(() {
                                  //   pageNo = StudentDetailsScreen.pageNo;
                                  // });
                                });
                              } else {
                                setState(() {
                                  _height += dragUpdateDetails.delta.dy *
                                      log(dragUpdateDetails
                                              .globalPosition.distance /
                                          175);
                                });
                              }
                            }
                            // else {
                            //   if (_height > 251) {
                            //     setState(() {
                            //       _height += dragUpdateDetails.delta.dy;
                            //     });
                            //   }
                            // }
                          },
                          onPressed: () {
                            drawerController.open();
                          },
                        ),
                        Expanded(
                            child: Container(
                          padding: EdgeInsets.all(12),
                          child: Column(
                            children: <Widget>[
                              Expanded(
                                child: Row(
                                  children: <Widget>[
                                    SizedBox(width: 12),
                                    HomeCard(
                                      color: Colors.white.withOpacity(0.8),
                                    ),
                                    SizedBox(width: 0),
                                    HomeCard(
                                      color: Colors.white.withOpacity(0.8),
                                    ),
                                    SizedBox(width: 8),
                                  ],
                                ),
                              ),
                              Expanded(
                                child: Row(
                                  children: <Widget>[
                                    SizedBox(width: 12),
                                    HomeCard(
                                      color: Colors.white.withOpacity(0.8),
                                    ),
                                    SizedBox(width: 12),
                                  ],
                                ),
                              ),
                              Expanded(
                                child: Row(
                                  children: <Widget>[
                                    SizedBox(width: 12),
                                    HomeCard(color: Colors.white.withOpacity(0.8)),
                                    HomeCard(color: Colors.white.withOpacity(0.8)),
                                    HomeCard(color: Colors.white.withOpacity(0.8)),
                                    SizedBox(
                                      width: 12,
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                        )),
                      ])),
                    ],
                  );
                }),
              ));
  }

  void setSelectedStudent(Student student) async {
    selectedStudent = student;
    if (selectedStudent != null) {
      setState(() {
        isLoading = false;
      });
    }
  }
}
