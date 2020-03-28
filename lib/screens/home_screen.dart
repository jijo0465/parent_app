import 'package:flutter/material.dart';
import 'package:parent_app/components/digi_appbar.dart';
import 'package:parent_app/components/digi_drawer.dart';
import 'package:parent_app/components/digi_menu_card.dart';
import 'package:parent_app/components/digicampus_appbar.dart';
import 'package:parent_app/screens/login_screen.dart';
import 'package:parent_app/screens/student_details_screen.dart';
import 'package:parent_app/states/login_state.dart';
import 'package:provider/provider.dart';

class HomeScreen extends DrawerContent {
  HomeScreen({Key key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

HiddenDrawerController drawerController;

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
    drawerController = HiddenDrawerController(
      initialPage: HomePage(
        title: 'main',
      ),
      items: [
        DrawerItem(
          text: Text('Home', style: TextStyle(color: Colors.white)),
          icon: Icon(Icons.home, color: Colors.white),
        ),
        DrawerItem(
          text: Text(
            'SETTINGS',
            style: TextStyle(color: Colors.white),
          ),
          icon: Icon(Icons.settings, color: Colors.white),
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
                                  TextStyle(color: Colors.white, fontSize: 20),
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
  static final List<IconData> _menuIcons = [
    Icons.accessibility_new,
    Icons.account_balance,
    Icons.account_box,
    Icons.add_a_photo,
    Icons.adjust,
    Icons.airplanemode_active
  ];
  static final List<Map<String, String>> _menuInfo = [
    {'title': 'Academics', 'subtitle': '90%', 'value': 'Check Result'},
    {'title': 'Bus No', 'subtitle': '15', 'value': 'Track School Bus'},
    {'title': 'Exam', 'subtitle': 'Mar 8th', 'value': 'Upcoming Exams'},
    {'title': 'Remarks', 'subtitle': '12', 'value': 'Write Remarks to Teacher'},
    {'title': 'Tasks', 'subtitle': '8', 'value': 'Digital School Diary'},
    {'title': 'Due Date', 'subtitle': 'Jan 12', 'value': 'Pay School Fees'}
  ];

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // ScrollController _pageController;
  double _top = 0;
  double _opacity = 0.0;
  double _height = 250.0;
  ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = new ScrollController();
    _scrollController.addListener(() {
      double offset = _scrollController.offset;
      double _h = 240;
      if (offset>120&&offset < 240) {
        setState(() {
          _top = offset - _h;
          _opacity = offset / 240;
        });
      }
      // else
      // {
      //   setState(() {
      //     _top = offset + _h;
      //     _opacity = offset * 120;
      //   });
      // }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: BottomNavigationBar(items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), title: Text('Home')),
          BottomNavigationBarItem(icon: Icon(Icons.info), title: Text('About'))
        ]),
        body: Stack(children: <Widget>[
          SingleChildScrollView(
              controller: _scrollController,
              scrollDirection: Axis.vertical,
              child: Column(children: [
                Container(
                  child: Column(children: [
                    DigiAppbar(
                      height: _height,
                      onDragEnd: (_) {
                        print(_height);
                        if (_height < 550) {
                          setState(() {
                            _height = 250;
                          });
                        }
                      },
                      onDrag: (dragUpdateDetails) {
                        //print(dragUpdateDetails.globalPosition.distance);
                        //print(dragUpdateDetails.globalPosition.dy);
                        print(dragUpdateDetails.primaryDelta);
                        if (dragUpdateDetails.delta.dy > 0) {
                          if (dragUpdateDetails.globalPosition.distance > 350) {
                            Navigator.push(
                              context,
                              PageRouteBuilder(
                                transitionDuration: Duration(milliseconds: 400),
                                pageBuilder: (_, __, ___) =>
                                    StudentDetailsScreen(),
                              ),
                            );
                          } else {
                            setState(() {
                              _height += dragUpdateDetails.delta.dy * 0.4;
                            });
                          }
                        } else {
                          if (_height > 251) {
                            setState(() {
                              _height += dragUpdateDetails.delta.dy;
                            });
                          }
                        }
                      },
                      onPressed: () {
                        drawerController.open();
                      },
                    ),
                    Container(
                      height: 300,
                      child: GridView.count(
                        mainAxisSpacing: 12,
                        scrollDirection: Axis.horizontal,
                        crossAxisCount: 2,
                        shrinkWrap: true,
                        children: List.generate(6, (index) {
                          return DigiMenuCard(
                              imagePath: 'assets/images/sir.jpg',
                              onPressed: () {
                                switch (index) {
                                  case 0:
                                    Navigator.of(context).pushNamed('/result');
                                    break;
                                  case 1:
                                    Navigator.of(context)
                                        .pushNamed('/attendance');
                                    break;
                                  case 2:
                                    Navigator.of(context)
                                        .pushNamed('/schoolbus');
                                    break;
                                  case 3:
                                    Navigator.of(context)
                                        .pushNamed('/inOut');
                                    break;
                                }
                              },
                              menuIcon: HomePage
                                  ._menuIcons[index], //_menuIcons(index),
                              title: HomePage._menuInfo[index]
                                  ['title'], //'Bus No',
                              subtitle: HomePage._menuInfo[index]['subtitle'],
                              value: HomePage._menuInfo[index]['value']);
                        }),
                      ),
                    ),
                    SizedBox(height: 12),
                    Container(
                        padding: EdgeInsets.only(left: 12),
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Digital School Diary',
                          textAlign: TextAlign.start,
                        )),
                    SizedBox(height: 12),
                    Container(
                      height: 160,
                      child: GridView.count(
                        mainAxisSpacing: 5,
                        scrollDirection: Axis.horizontal,
                        crossAxisCount: 1,
                        shrinkWrap: true,
                        children: List.generate(6, (index) {
                          return DigiMenuCard(
                              imagePath: 'assets/images/sir.jpg',
                              onPressed: () {
                                Navigator.of(context).pushNamed('/timetable');
                              },
                              menuIcon: HomePage
                                  ._menuIcons[index], //_menuIcons(index),
                              title: HomePage._menuInfo[index]
                                  ['title'], //'Bus No',
                              subtitle: HomePage._menuInfo[index]['subtitle'],
                              value: HomePage._menuInfo[index]['value']);
                        }),
                      ),
                    ),
                    SizedBox(height: 120)
                  ]),
                ),
              ])),
          Positioned(
            top: _top,
            child: Opacity(
              opacity: _opacity,
              child: DigiCampusAppbar(
                icon: Icons.menu,
                onDrawerTapped: () {
                  drawerController.open();
                },
              ),
            ),
          )
        ]));
  }
}
