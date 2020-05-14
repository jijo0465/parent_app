import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:parent_app/components/digi_screen_title.dart';
import 'package:parent_app/components/digicampus_appbar.dart';
import 'package:table_calendar/table_calendar.dart';

class AttendanceScreen extends StatefulWidget {
  const AttendanceScreen({Key key}) : super(key: key);

  @override
  _AttendanceScreenState createState() => _AttendanceScreenState();
}

class _AttendanceScreenState extends State<AttendanceScreen> {
  CalendarController _calendarController;
  Map<DateTime, List<bool>> _events = {};
  bool isPresent = true;
  double _height = 600;
  DateTime _selectedDay;
  DateTime _date;
  DateTime _startDate;
  DateTime _endDate;
  DateFormat dateFormat = DateFormat.E();
  String formattedDay;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      setState(() {
        _height = 0;
      });
    });
    _calendarController = CalendarController();
    _selectedDay = DateTime.now();
    _startDate = DateTime(2020, 02, 15);
    _endDate = DateTime(2021, 01, 12);
    _date = _startDate;
    final length = DateTime.now().difference(_startDate);
    // print(length);

    // _events.addAll({
    //   List.generate(length.inDays, (index) {
    //   _selectedDay.add(Duration(days: 1));
    //   return
    //   _events = Map.from({
    //     _selectedDay: [true]
    //   });
    // })});

    List.generate(length.inDays, (index) {
      // print(index);
      _date = _date.add(Duration(days: 1));
      formattedDay = dateFormat.format(_date);
      print(formattedDay);
      if((formattedDay!='Sun')&&(formattedDay!='Sat')){
        _events[_date] = [true];
      }
    });

    // _date = DateTime.now().subtract(Duration(days: 14));
    // _events.update(_date, (_) => [false]);
    // _date = DateTime.now().subtract(Duration(days: 21));
    // // _events.update(_date, (_) => [false]);
    _events.update(DateTime(2020,05,05), (value) => [false]);
    _events.update(DateTime(2020,04,13), (value) => [false]);
    _events.update(DateTime(2020,04,14), (value) => [false]);
    _events.update(DateTime(2020,03,24), (value) => [false]);

    // _events.remove(DateTime(2020,06,27));
    // _events.remove(DateTime(2020,06,27));


    // _events.forEach((key, value) { 
    //   print('$key : ${[value]}');
    // });
    

    // _selectedDay: [true],
    // _selectedDay.add(Duration(days: 1)): [true],
    // _selectedDay.add(Duration(days: 3)): [true],
    // _selectedDay.add(Duration(days: 7)): [true],
    // _selectedDay.add(Duration(days: 11)): [true],
    // _selectedDay.add(Duration(days: 17)): [true],
    // _selectedDay.add(Duration(days: 22)): [true],
    // _selectedDay.add(Duration(days: 26)): [true],
    // // };
    // _selectedDay = DateTime.now();
    super.initState();
  }

  @override
  void dispose() {
    _calendarController.dispose();
    super.dispose();
  }

  void markAttendance() {}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(children: [
      DigiCampusAppbar(
        icon: Icons.close,
        onDrawerTapped: () {
          Navigator.of(context).pop();
        },
      ),
      SizedBox(height: 12),
      DigiScreenTitle(text: 'Attendance'),
      SizedBox(height: 8),
      Card(
        child: Container(
          padding: EdgeInsets.all(12),
          width: MediaQuery.of(context).size.width * 0.8,
          child: Column(children: <Widget>[
            Container(child: Text('In-Time : 9:00 a.m.')),
            Container(child: Text('Out-Time : 3:30 p.m. ')),
          ]),
        ),
      ),
      SizedBox(height: 8),
      AnimatedPadding(
          padding: EdgeInsets.only(top: _height),
          duration: Duration(milliseconds: 600)),
      Expanded(
        child: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Theme.of(context).primaryColor.withOpacity(0.8),
                  Theme.of(context).primaryColor,
                  Theme.of(context).primaryColor.withOpacity(0.8)
                ],
                // tileMode: TileMode.repeated,
              ),
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(34), topRight: Radius.circular(34))),
          width: MediaQuery.of(context).size.width,
          child: Column(
            children: <Widget>[
              Expanded(
                child: TableCalendar(
                  // rowHeight: 30,
                  startDay: _startDate,
                  endDay: _endDate,
                  calendarController: _calendarController,
                  events: _events,
                  formatAnimation: FormatAnimation.scale,
                  availableGestures: AvailableGestures.horizontalSwipe,
                  calendarStyle: CalendarStyle(
                      markersAlignment: Alignment.bottomRight,
                      //outsideStyle:TextStyle(color:Colors.grey,fontStyle: FontStyle.italic) ,
                      selectedColor: Theme.of(context).primaryColor,
                      weekdayStyle: TextStyle(
                        color: Colors.white,
                      )),
                  headerStyle: HeaderStyle(
                      formatButtonTextStyle:
                          TextStyle(fontSize: 12, color: Colors.greenAccent),
                      centerHeaderTitle: true,
                      titleTextStyle: TextStyle(
                          color: Colors.black,
                          fontSize: 17,
                          fontWeight: FontWeight.w600)),
                  daysOfWeekStyle: DaysOfWeekStyle(
                      weekdayStyle: TextStyle(color: Colors.blueGrey[100])),
                  builders: CalendarBuilders(
                    markersBuilder: (context, date, events, holidays) {
                      final children = <Widget>[];
                      if (events.isNotEmpty) {
                        children.add(
                          Positioned(
                            right: 1,
                            bottom: 1,
                            child: _buildEventsMarker(date, events),
                          ),
                        );
                      }

                      // if (holidays.isNotEmpty) {
                      //   children.add(
                      //     Positioned(
                      //       right: -2,
                      //       top: -2,
                      //       child: _buildHolidaysMarker(),
                      //     ),
                      //   );
                      // }

                      return children;
                    },
                  ),
                ),
              ),
              // SizedBox(height: 8),
              // Container(
              //   alignment: Alignment.bottomCenter,
              //   child: Row(
              //     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              //     children: <Widget>[
              //       RaisedButton(
              //           onPressed: () {
              //             Navigator.pushNamed(context, '/chat');
              //           },
              //           child: Text('Message Teacher')),
              //       RaisedButton(
              //           onPressed: () {}, child: Text('Contact Teacher'))
              //     ],
              //   ),
              // ),
              SizedBox(
                height: 8,
              ),
            ],
          ),
        ),
      ),
    ]));
  }

  Widget _buildEventsMarker(DateTime date, List events) {
    if (events.first == true) {
      return Icon(
        CupertinoIcons.check_mark_circled_solid,
        size: 20.0,
        color: Colors.green[300],
      );
    } else {
      return Icon(Icons.close, size: 20, color: Colors.red[600]);
    }
    // AnimatedContainer(
    // //   duration: const Duration(milliseconds: 300),
    // //   decoration: BoxDecoration(
    // //     shape: BoxShape.rectangle,
    // //     color: _calendarController.isSelected(date)
    // //         ? Colors.brown[500]
    // //         : _calendarController.isToday(date) ? Colors.brown[300] : Colors.blue[400],
    // //   ),
    // //   width: 16.0,
    // //   height: 16.0,
    // //   child: Center(
    // //     child: Text(
    // //       '${events.length}',
    // //       style: TextStyle().copyWith(
    // //         color: Colors.white,
    // //         fontSize: 12.0,
    // //       ),
    // //     ),
    // //   ),
    // // );
    //       // duration: const Duration(milliseconds: 300),
    //       // height: 3,
    //       // width: 5,
    //       // child: Icon(
    //       //   Icons.check,
    //       //   color: Colors.green,
    //       //   size:5
    //       // )
    // );
  }
}
