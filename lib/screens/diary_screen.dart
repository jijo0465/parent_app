import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:month_picker_dialog/month_picker_dialog.dart';
import 'package:parent_app/components/data.dart';
import 'package:parent_app/components/digicampus_appbar.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:page_turn/page_turn.dart';

class DiaryScreen extends StatefulWidget {
  const DiaryScreen({Key key}) : super(key: key);

  @override
  _DiaryScreenState createState() => _DiaryScreenState();
}

class _DiaryScreenState extends State<DiaryScreen>
    with TickerProviderStateMixin {
  CalendarController _calendarController;
  AnimationController _animationController;
  final _pageTurnController = GlobalKey<PageTurnState>();

  Map<String, dynamic> diary;
  final List<Map> subjectList = [
    {
      "0": "Class Test",
      "1": "2020-06-02",
      "2": "Java",
      "3": "0",
      "4": "<Event detail>",
    },
    {
      "0": "Class Test",
      "1": "2020-05-05",
      "2": "Android",
      "3": "0",
      "4": "<Event detail>",
    },
    {
      "0": "Class Test",
      "1": "2020-06-06",
      "2": "Java",
      "3": "0",
      "4": "<Event detail>",
    },
    {
      "0": "Mid-Term",
      "1": "2020-06-07",
      "2": "Java",
      "3": "1",
      "4": "<Event detail>",
    },
    {
      "0": "Class Test",
      "1": "2020-06-08",
      "2": "Java",
      "3": "0",
      "4": "<Event detail>",
    },
    {
      "0": "Mid-Term",
      "1": "2020-06-12",
      "2": "Java",
      "3": "1",
      "4": "<Event detail>",
    },
    {
      "0": "Class Test",
      "1": "2020-06-15",
      "2": "Java",
      "3": "0",
      "4": "<Event detail>",
    }
  ];

  DateTime startDate;
  DateTime endDate;
  DateTime selectedDate;
  double x;
  double x1;
  double x2;
  double y;
  double z;
  double tempValue;
  Duration duration = Duration(milliseconds: 300);
  int diaryPage;
  int tweenFlag = 3;
  bool isUnavailableDay = false;
  Comparator<dynamic> dateComparator =
      (a, b) => DateTime.parse(a['1']).compareTo(DateTime.parse(b['1']));
  List<Widget> childrenPages = <Widget>[];
  // T transform(double t);

  @override
  void initState() {
    initializeDateFormatting();
    // WidgetsBinding.instance.addPostFrameCallback((_) {
    //   for (var i = 0; i <= 6; i++) {
    //     childrenPages.add(_newPage(i));
    //   }
    // });
    _calendarController = CalendarController();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 350),
    );
    _animationController.forward();

    startDate = DateTime(2019, 05, 15);
    endDate = DateTime.now().add(Duration(days: 2));
    selectedDate = DateTime.now();
    diaryPage = selectedDate.day % 6;
    print(diaryPage);

    subjectList.sort(dateComparator);
    print(diary);
    setState(() {
      diary = Map<String, dynamic>.from(subjectList.elementAt(diaryPage));
    });

    x = 0;
    y = 0;
    z = 0.002;
    x1 = -0.010;
    x2 = 0;
    super.initState();
  }

  // void addPages() {
  //   for (var i = 0; i <= 6; i++) {
  //     childrenPages.add(_newPage(i));
  //   }

  // }

  Widget _newPage(int index) {
    diary = Map<String, dynamic>.from(subjectList.elementAt(index));
    return RotatedBox(
      quarterTurns: -1,
      child: Container(
        height: 350,
        alignment: Alignment.topLeft,
        margin: EdgeInsets.only(left: 30, right: 70),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Divider(
              height: 4,
              color: Colors.deepOrange[300],
              thickness: 3,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text('0 : ${diary['0']}'),
            ),
            Divider(
              height: 4,
              color: Colors.deepOrange[300],
              thickness: 1.5,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text('1 : ${diary['4']}'),
            ),
            Divider(
              height: 4,
              color: Colors.deepOrange[300],
              thickness: 1.5,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text('2 : ${diary['2']}'),
            ),
            Divider(
              height: 4,
              color: Colors.deepOrange[300],
              thickness: 1.5,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text('3 : ${diary['3']}'),
            ),
            Divider(
              height: 4,
              color: Colors.deepOrange[300],
              thickness: 3,
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _calendarController.dispose();
    _animationController.dispose();
    // _pageTurnController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          children: <Widget>[
            DigiCampusAppbar(
              icon: Icons.close,
              onDrawerTapped: () {
                Navigator.of(context).pop();
              },
            ),
            SizedBox(height: 12),
            Stack(
              children: <Widget>[
                // Container(
                //   height: 150,
                //   width: double.infinity,
                //   padding: EdgeInsets.all(12),
                //   decoration: BoxDecoration(
                //       borderRadius: BorderRadius.circular(20),
                //       image: DecorationImage(
                //           image: AssetImage('assets/images/menu_7.png'),
                //           fit: BoxFit.cover)),
                //   // child: Hero(
                //   //   tag: 'schoolDiary',
                //   //   child: Image(
                //   //       image: AssetImage('assets/images/menu_7.png'),
                //   //       fit: BoxFit.cover),)
                // ),
                SizedBox(height: 140),
                TweenAnimationBuilder(
                    tween: Tween<double>(begin: x1, end: x2),
                    duration: duration,
                    onEnd: () {
                      setState(() {
                        if (tweenFlag >= 0) {
                          tempValue = x1;
                          x1 = x2;
                          x2 = -tempValue + 0.0004;
                          print('x1: $x1 , x2: $x2');
                          tweenFlag--;
                        }
                      });
                    },
                    // curve: Curves.bounceOut,
                    builder: (_, double value, __) {
                      return Transform(
                        transform: Matrix4(
                          1, 0, 0, 0,
                          0, 1, 0, 0,
                          0, 0, 1, z,
                          0, 0, 0, 1,
                        )
                          ..rotateX(value)
                          ..rotateY(y)
                          ..rotateZ(z),
                        //     child: ,
                        // },
                        // child: Transform(
                        //     // origin: Offset(x,y),
                        //     transform: Matrix4(
                        //       1, 0, 0, 0,
                        //       0, 1, 0, 0,
                        //       0, 0, 1, z,
                        //       0, 0, 0, 1,
                        //     )
                        //       ..rotateX(x)
                        //       ..rotateY(y)
                        //       ..rotateZ(z),
                        // child: GestureDetector(
                        // onPanUpdate: (details) {
                        //   setState(() {
                        //     //y = y - details.delta.dx / 100;
                        //     x = x + details.delta.dy / 100;
                        //     print(x);
                        //   });
                        // },
                        child: Container(
                          child: Stack(
                            children: <Widget>[
                              Container(
                                margin: EdgeInsets.only(left: 12),
                                width: double.infinity,
                                height: 400,
                                child: Image(
                                  image: AssetImage(
                                      'assets/images/diary_header.png'),
                                  fit: BoxFit.fill,
                                ),
                              ),
                              Column(
                                children: <Widget>[
                                  SizedBox(height: 31),
                                  Container(
                                    width: double.infinity,
                                    padding: EdgeInsets.all(12),
                                    margin:
                                        EdgeInsets.only(left: 20, right: 60),
                                    child: TableCalendar(
                                        dayHitTestBehavior:
                                            HitTestBehavior.translucent,
                                        daysOfWeekStyle: DaysOfWeekStyle(
                                            weekdayStyle: TextStyle(
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold),
                                            weekendStyle: TextStyle(
                                                color: Colors.red,
                                                fontWeight: FontWeight.bold)),
                                        // rowHeight: 0.25,
                                        // simpleSwipeConfig: ,
                                        // dayHitTestBehavior: null,
                                        calendarController: _calendarController,
                                        formatAnimation: FormatAnimation.slide,
                                        // availableGestures: AvailableGestures.all,
                                        initialCalendarFormat:
                                            CalendarFormat.week,
                                        availableCalendarFormats: {
                                          CalendarFormat.week: 'Week',
                                          CalendarFormat.twoWeeks: '2 Weeks'
                                        },
                                        // calendarStyle: CalendarStyle(
                                        //   weekdayStyle: TextStyle(
                                        //     color: Colors.black,
                                        //   ),
                                        //   outsideStyle: TextStyle(
                                        //     color: Colors.grey,
                                        //     fontStyle: FontStyle.italic,
                                        //     decorationStyle:
                                        //         TextDecorationStyle.dotted,
                                        //   ),
                                        //  selectedColor:
                                        //      Theme.of(context).primaryColor,
                                        // highlightSelected: true,
                                        //   selectedStyle: TextStyle(
                                        //       color: Colors.red[300],
                                        //       fontSize: 16),
                                        //   todayColor: Colors.blue[800],
                                        //  ),
                                        headerVisible: false,
                                        // headerStyle: HeaderStyle(
                                        //     // centerHeaderTitle: true,
                                        //     formatButtonTextStyle: TextStyle(
                                        //       fontSize: 12,
                                        //       color: Colors.white
                                        //     ),
                                        //     titleTextStyle: TextStyle(
                                        //         fontSize: 17,
                                        //         fontWeight: FontWeight.w600,
                                        //         color: Colors.white)),
                                        // onHeaderTapped: (date) {
                                        //   showMonthPicker(
                                        //           context: context,
                                        //           initialDate: date,
                                        //           firstDate: startDate,
                                        //           lastDate: endDate)
                                        //       .then((date) {
                                        //     selectedDate = date;
                                        //     //updateCalendar();
                                        //   });
                                        // },
                                        onDaySelected: (date, list) {
                                          setState(() {
                                            selectedDate = date;
                                            diaryPage = date.day % 6;
                                            _pageTurnController.currentState.goToPage(diaryPage);
                                            // diary = Map<String, dynamic>.from(
                                            //     subjectList
                                            //         .elementAt(diaryPage));
                                            // print(diaryPage);
                                          });
                                        },
                                        onUnavailableDaySelected: () {
                                          setState(() {
                                            isUnavailableDay = true;
                                          });
                                        },
                                        builders: CalendarBuilders(
                                          selectedDayBuilder:
                                              (context, date, _) {
                                            return FadeTransition(
                                              opacity:
                                                  Tween(begin: 0.0, end: 1.0)
                                                      .animate(
                                                          _animationController),
                                              child: Container(
                                                // margin: const EdgeInsets.only(top: 8),
                                                decoration: BoxDecoration(
                                                    color:
                                                        Colors.deepOrange[300],
                                                    borderRadius:
                                                        BorderRadius.only(
                                                            topLeft:
                                                                Radius.circular(
                                                                    20),
                                                            topRight: Radius
                                                                .circular(20))),
                                                // padding: const EdgeInsets.only(top: 5.0, left: 6.0),
                                                // color: Colors.deepOrange[300],
                                                alignment: Alignment.center,
                                                // width: 50,
                                                // height: 50,
                                                child: Text(
                                                  '${date.day}',
                                                  style: TextStyle().copyWith(
                                                      fontSize: 16.0,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              ),
                                            );
                                          },
                                          dayBuilder: (context, date, _) {
                                            return Container(
                                                // margin: const EdgeInsets.all(4.0),
                                                // padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 5),
                                                alignment: Alignment.center,
                                                // color: Colors.blue[300],
                                                // width: 50,
                                                // height: 50,
                                                child: Text(
                                                  '${date.day}',
                                                  style: TextStyle().copyWith(
                                                      fontSize: 14.0,
                                                      fontWeight:
                                                          FontWeight.w500),
                                                ));
                                          },
                                          outsideDayBuilder: (conext, date, _) {
                                            return Container(
                                                alignment: Alignment.center,
                                                // color: Colors.blue[300],
                                                // width: 50,
                                                // height: 50,
                                                child: Text(
                                                  '${date.day}',
                                                  style: TextStyle().copyWith(
                                                      fontSize: 14.0,
                                                      fontStyle:
                                                          FontStyle.italic,
                                                      fontWeight:
                                                          FontWeight.w300),
                                                ));
                                          },
                                          weekendDayBuilder: (conext, date, _) {
                                            return Container(
                                                alignment: Alignment.center,
                                                child: Text(
                                                  '${date.day}',
                                                  style: TextStyle().copyWith(
                                                      fontSize: 14.0,
                                                      fontStyle:
                                                          FontStyle.italic,
                                                      fontWeight:
                                                          FontWeight.w300),
                                                ));
                                          },
                                          outsideWeekendDayBuilder:
                                              (conext, date, _) {
                                            return Container(
                                                alignment: Alignment.center,
                                                child: Text(
                                                  '${date.day}',
                                                  style: TextStyle().copyWith(
                                                      fontSize: 14.0,
                                                      fontStyle:
                                                          FontStyle.italic,
                                                      fontWeight:
                                                          FontWeight.w300),
                                                ));
                                          },
                                        )),
                                  ),
                                  Container(
                                    height: 250,
                                    width: double.infinity,
                                    margin: EdgeInsets.only(left: 30, right: 70),
                                    child: RotatedBox(
                                      quarterTurns: 1,
                                      child: Container(
                                        child: PageTurn(                                        
                                          // initialIndex: diaryPage,
                                          key: _pageTurnController,
                                          backgroundColor: Color(0xffdad6ca),
                                          showDragCutoff: false,
                                          lastPage: Container(
                                              child:Center(child: Text('Last Page!'))),
                                          children: <Widget>[
                                            for (int i = 0; i <= 6; i++) _newPage(i),
                                          ],
                                          //   Container(
                                          //   alignment: Alignment.topLeft,
                                          //   margin: EdgeInsets.only(left: 30,right: 70),
                                          //   child: Column(
                                          //     crossAxisAlignment: CrossAxisAlignment.start,
                                          //     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                          //     children: <Widget>[
                                          //   Divider(height: 4,
                                          //     color: Colors.deepOrange[300],
                                          //     thickness: 3,),
                                          //   Padding(
                                          //     padding: const EdgeInsets.all(8.0),
                                          //     child: Text('0 : ${diary['0']}'),
                                          //   ),
                                          //   Divider(height: 4,
                                          //     color: Colors.deepOrange[300],
                                          //     thickness: 1.5,),
                                          //   Padding(
                                          //     padding: const EdgeInsets.all(8.0),
                                          //     child: Text('1 : ${diary['4']}'),
                                          //   ),
                                          //   Divider(height: 4,
                                          //     color: Colors.deepOrange[300],
                                          //     thickness: 1.5,),
                                          //   Padding(
                                          //     padding: const EdgeInsets.all(8.0),
                                          //     child: Text('2 : ${diary['2']}'),
                                          //   ),
                                          //   Divider(height: 4,
                                          //     color: Colors.deepOrange[300],
                                          //     thickness: 1.5,),
                                          //   Padding(
                                          //     padding: const EdgeInsets.all(8.0),
                                          //     child: Text('3 : ${diary['3']}'),
                                          //   ),
                                          //   Divider(height: 4,
                                          //     color: Colors.deepOrange[300],
                                          //     thickness: 3,),
                                          //   ],
                                          //   ),
                                          // ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        // )
                      );
                    }),
              ],
            ),
            // Stack(children: <Widget>[
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.end,
            //   crossAxisAlignment: CrossAxisAlignment.center,
            //   children: <Widget>[
            //     GestureDetector(
            //       behavior: HitTestBehavior.opaque,
            //       onTap: () {
            //         showMonthPicker(
            //                 context: context,
            //                 initialDate: selectedDate,
            //                 firstDate: startDate,
            //                 lastDate: endDate)
            //             .then((date) {
            //           selectedDate = date;
            //           //updateCalendar();
            //         });
            //       },
            //       child: Opacity(
            //         opacity: 0.7,
            //         child: Container(
            //           height: 50,
            //           width: 50,
            //           decoration: BoxDecoration(
            //               gradient: LinearGradient(
            //                   colors: [Colors.blue[800], Colors.blue[200]]),
            //               borderRadius: BorderRadius.only(
            //                   topLeft: Radius.circular(20),
            //                   bottomLeft: Radius.circular(20))),
            //           child: Icon(Icons.calendar_view_day,
            //               size: 40, color: Colors.white),
            //         ),
            //       ),
            //     ),
            //   ],
            // ),

            // ]),
          ],
        ),
      ),
    );
  }
}
